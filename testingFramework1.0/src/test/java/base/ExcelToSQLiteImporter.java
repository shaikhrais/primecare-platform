package base;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelToSQLiteImporter {

    public void importExcel(
            String excelFilePath
    ) {

        SQLiteVerificationDatabase.createTables();

        int rowsRead = 0;
        int rowsInserted = 0;
        int rowsUpdated = 0;
        int rowsFailed = 0;

        DataFormatter formatter =
                new DataFormatter();

        try (
                FileInputStream inputStream =
                        new FileInputStream(
                                excelFilePath
                        );

                XSSFWorkbook workbook =
                        new XSSFWorkbook(
                                inputStream
                        );

                Connection connection =
                        SQLiteVerificationDatabase
                                .getConnection()
        ) {

            connection.setAutoCommit(false);

            long runId =
                    createTestRun(
                            connection,
                            excelFilePath
                    );

            Sheet sheet =
                    workbook.getSheet(
                            "Screen Verification"
                    );

            if (sheet == null) {

                throw new IllegalStateException(
                        "Screen Verification sheet was not found."
                );
            }

            for (
                    int rowIndex = 1;
                    rowIndex <= sheet.getLastRowNum();
                    rowIndex++
            ) {

                Row row =
                        sheet.getRow(rowIndex);

                if (row == null) {
                    continue;
                }

                rowsRead++;

                try {

                    VerificationResult result =
                            readResult(
                                    row,
                                    formatter
                            );

                    insertTestCaseResult(
                            connection,
                            runId,
                            result
                    );

                    rowsInserted++;

                    updateScreenVerification(
                            connection,
                            runId,
                            result
                    );

                    rowsUpdated++;

                } catch (Exception exception) {

                    rowsFailed++;

                    System.err.println(
                            "[SQLITE IMPORT] Row "
                                    + rowIndex
                                    + " failed: "
                                    + exception.getMessage()
                    );
                }
            }
            Sheet recoverySheet =
                    workbook.getSheet(
                            "Navigation Recovery"
                    );

            if (recoverySheet != null) {
                for (
                        int rowIndex = 1;
                        rowIndex <= recoverySheet.getLastRowNum();
                        rowIndex++
                ) {
                    Row row =
                            recoverySheet.getRow(rowIndex);

                    if (row == null) {
                        continue;
                    }

                    try {
                        insertNavigationRecoveryResult(
                                connection,
                                runId,
                                row,
                                formatter
                        );
                    } catch (Exception exception) {
                        System.err.println(
                                "[SQLITE IMPORT] Recovery Row "
                                        + rowIndex
                                        + " failed: "
                                        + exception.getMessage()
                        );
                    }
                }
            }

            completeTestRun(
                    connection,
                    runId,
                    rowsRead,
                    excelFilePath
            );

            insertImportLog(
                    connection,
                    runId,
                    excelFilePath,
                    rowsRead,
                    rowsInserted,
                    rowsUpdated,
                    rowsFailed,
                    rowsFailed == 0
                            ? "SUCCESS"
                            : "PARTIAL_SUCCESS",
                    null
            );

            connection.commit();

            System.out.println(
                    "[SQLITE IMPORT] Completed."
                            + "\nRows read: "
                            + rowsRead
                            + "\nRows inserted: "
                            + rowsInserted
                            + "\nScreens updated: "
                            + rowsUpdated
                            + "\nRows failed: "
                            + rowsFailed
            );

        } catch (Exception exception) {

            throw new RuntimeException(
                    "Excel-to-SQLite import failed for: "
                            + excelFilePath,
                    exception
            );
        }
    }

    private VerificationResult readResult(
            Row row,
            DataFormatter formatter
    ) {

        VerificationResult result =
                new VerificationResult();

        result.setScreenId(
                parseInteger(
                        formatter.formatCellValue(
                                row.getCell(0)
                        )
                )
        );

        result.setTestClass(
                formatter.formatCellValue(
                        row.getCell(1)
                )
        );

        result.setTestMethod(
                formatter.formatCellValue(
                        row.getCell(2)
                )
        );

        result.setExpectedPage(
                formatter.formatCellValue(
                        row.getCell(3)
                )
        );

        result.setActualPage(
                formatter.formatCellValue(
                        row.getCell(4)
                )
        );

        result.setExpectedRoute(
                formatter.formatCellValue(
                        row.getCell(5)
                )
        );

        result.setActualUrl(
                formatter.formatCellValue(
                        row.getCell(6)
                )
        );

        result.setRouteVerified(
                parseBoolean(
                        formatter.formatCellValue(
                                row.getCell(7)
                        )
                )
        );

        result.setPageVerified(
                parseBoolean(
                        formatter.formatCellValue(
                                row.getCell(8)
                        )
                )
        );

        result.setComponentVerified(
                parseBoolean(
                        formatter.formatCellValue(
                                row.getCell(9)
                        )
                )
        );

        result.setErrorPageFound(
                parseBoolean(
                        formatter.formatCellValue(
                                row.getCell(10)
                        )
                )
        );

        result.setTestStatus(
                formatter.formatCellValue(
                        row.getCell(11)
                )
        );

        result.setFailureMessage(
                formatter.formatCellValue(
                        row.getCell(12)
                )
        );

        result.setExecutionTimeMs(
                parseLong(
                        formatter.formatCellValue(
                                row.getCell(13)
                        )
                )
        );

        return result;
    }

    private long createTestRun(
            Connection connection,
            String excelFilePath
    ) throws Exception {

        String sql =
                """
                INSERT INTO test_run (
                    suite_name,
                    started_at,
                    excel_file_path,
                    import_status
                )
                VALUES (?, datetime('now'), ?, 'IMPORTING')
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            statement.setString(
                    1,
                    "PrimeCare TestNG Verification"
            );

            statement.setString(
                    2,
                    excelFilePath
            );

            statement.executeUpdate();

            try (
                    java.sql.ResultSet keys =
                            statement.getGeneratedKeys()
            ) {

                if (keys.next()) {
                    return keys.getLong(1);
                }
            }
        }

        throw new IllegalStateException(
                "Unable to create test run."
        );
    }

    private void insertTestCaseResult(
            Connection connection,
            long runId,
            VerificationResult result
    ) throws Exception {

        String sql =
                """
                INSERT INTO test_case_result (
                    run_id,
                    screen_id,
                    test_class,
                    test_method,
                    expected_page,
                    actual_page,
                    expected_route,
                    actual_url,
                    route_verified,
                    page_verified,
                    component_verified,
                    error_page_found,
                    test_status,
                    failure_message,
                    execution_time_ms,
                    verified_at
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, runId);
            statement.setInt(2, result.getScreenId());
            statement.setString(3, result.getTestClass());
            statement.setString(4, result.getTestMethod());
            statement.setString(5, result.getExpectedPage());
            statement.setString(6, result.getActualPage());
            statement.setString(7, result.getExpectedRoute());
            statement.setString(8, result.getActualUrl());
            statement.setInt(9, result.isRouteVerified() ? 1 : 0);
            statement.setInt(10, result.isPageVerified() ? 1 : 0);
            statement.setInt(11, result.isComponentVerified() ? 1 : 0);
            statement.setInt(12, result.isErrorPageFound() ? 1 : 0);
            statement.setString(13, result.getTestStatus());
            statement.setString(14, result.getFailureMessage());
            statement.setLong(15, result.getExecutionTimeMs());

            statement.executeUpdate();
        }
    }

    private void updateScreenVerification(
            Connection connection,
            long runId,
            VerificationResult result
    ) throws Exception {

        String finalStatus =
                result.isRouteVerified()
                        && result.isPageVerified()
                        && result.isComponentVerified()
                        && !result.isErrorPageFound()
                        && "PASSED".equalsIgnoreCase(
                                result.getTestStatus()
                        )
                        ? "PASSED"
                        : "FAILED";

        String sql =
                """
                INSERT INTO screen_verification (
                    screen_id,
                    expected_title,
                    expected_route,
                    actual_title,
                    actual_url,
                    route_loaded,
                    page_verified,
                    main_content_found,
                    component_verified,
                    placeholder_found,
                    error_page_found,
                    final_status,
                    failure_message,
                    last_test_run_id,
                    verified_at
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
                ON CONFLICT(screen_id)
                DO UPDATE SET
                    expected_title = excluded.expected_title,
                    expected_route = excluded.expected_route,
                    actual_title = excluded.actual_title,
                    actual_url = excluded.actual_url,
                    route_loaded = max(route_loaded, excluded.route_loaded),
                    page_verified = max(page_verified, excluded.page_verified),
                    main_content_found = max(main_content_found, excluded.main_content_found),
                    component_verified = max(component_verified, excluded.component_verified),
                    placeholder_found = max(placeholder_found, excluded.placeholder_found),
                    error_page_found = max(error_page_found, excluded.error_page_found),
                    final_status = CASE 
                        WHEN max(route_loaded, excluded.route_loaded) = 1 
                             AND max(page_verified, excluded.page_verified) = 1 
                             AND max(component_verified, excluded.component_verified) = 1 
                             AND max(error_page_found, excluded.error_page_found) = 0 
                        THEN 'PASSED'
                        ELSE 'FAILED'
                    END,
                    failure_message = CASE 
                        WHEN excluded.failure_message IS NOT NULL AND excluded.failure_message != '' THEN excluded.failure_message
                        ELSE failure_message
                    END,
                    last_test_run_id = excluded.last_test_run_id,
                    verified_at = datetime('now')
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, result.getScreenId());
            statement.setString(2, result.getExpectedPage());
            statement.setString(3, result.getExpectedRoute());
            statement.setString(4, result.getActualPage());
            statement.setString(5, result.getActualUrl());
            statement.setInt(6, result.isRouteVerified() ? 1 : 0);
            statement.setInt(7, result.isPageVerified() ? 1 : 0);
            statement.setInt(8, result.isPageVerified() ? 1 : 0);
            statement.setInt(9, result.isComponentVerified() ? 1 : 0);
            statement.setInt(10, result.isErrorPageFound() ? 1 : 0);
            statement.setInt(11, result.isErrorPageFound() ? 1 : 0);
            statement.setString(12, finalStatus);
            statement.setString(13, result.getFailureMessage());
            statement.setLong(14, runId);

            statement.executeUpdate();
        }
    }

    private void completeTestRun(
            Connection connection,
            long runId,
            int totalTests,
            String excelFilePath
    ) throws Exception {

        String sql =
                """
                UPDATE test_run
                SET completed_at = datetime('now'),
                    total_tests = ?,
                    excel_file_path = ?,
                    import_status = 'IMPORTED'
                WHERE run_id = ?
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, totalTests);
            statement.setString(2, excelFilePath);
            statement.setLong(3, runId);

            statement.executeUpdate();
        }
    }

    private void insertImportLog(
            Connection connection,
            long runId,
            String filePath,
            int rowsRead,
            int rowsInserted,
            int rowsUpdated,
            int rowsFailed,
            String status,
            String errorMessage
    ) throws Exception {

        String sql =
                """
                INSERT INTO excel_import_log (
                    run_id,
                    excel_file_path,
                    rows_read,
                    rows_inserted,
                    rows_updated,
                    rows_failed,
                    import_status,
                    error_message,
                    imported_at
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, runId);
            statement.setString(2, filePath);
            statement.setInt(3, rowsRead);
            statement.setInt(4, rowsInserted);
            statement.setInt(5, rowsUpdated);
            statement.setInt(6, rowsFailed);
            statement.setString(7, status);
            statement.setString(8, errorMessage);

            statement.executeUpdate();
        }
    }

    private int parseInteger(String value) {
        return value == null || value.isBlank()
                ? 0
                : (int) Double.parseDouble(value);
    }

    private long parseLong(String value) {
        return value == null || value.isBlank()
                ? 0L
                : (long) Double.parseDouble(value);
    }

    private void insertNavigationRecoveryResult(
            Connection connection,
            long runId,
            Row row,
            DataFormatter formatter
    ) throws Exception {

        String sql =
                """
                INSERT INTO navigation_recovery (
                    run_id,
                    screen_id,
                    requested_url,
                    expected_route,
                    expected_page,
                    actual_url,
                    actual_page,
                    browser_title,
                    attempt_count,
                    language_page_detected,
                    language_selection_succeeded,
                    login_page_detected,
                    login_succeeded,
                    route_verified,
                    title_verified,
                    page_marker_verified,
                    main_content_verified,
                    error_page_detected,
                    access_denied,
                    resource_busy,
                    resource_not_found,
                    failure_type,
                    failure_message,
                    screenshot_path,
                    final_status,
                    verified_at
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
                """;

        try (
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setLong(1, runId);
            statement.setInt(2, parseInteger(formatter.formatCellValue(row.getCell(1))));
            statement.setString(3, formatter.formatCellValue(row.getCell(2)));
            statement.setString(4, formatter.formatCellValue(row.getCell(3)));
            statement.setString(5, formatter.formatCellValue(row.getCell(4)));
            statement.setString(6, formatter.formatCellValue(row.getCell(5)));
            statement.setString(7, formatter.formatCellValue(row.getCell(6)));
            statement.setString(8, formatter.formatCellValue(row.getCell(7)));
            statement.setInt(9, parseInteger(formatter.formatCellValue(row.getCell(8))));
            statement.setInt(10, parseBoolean(formatter.formatCellValue(row.getCell(9))) ? 1 : 0);
            statement.setInt(11, parseBoolean(formatter.formatCellValue(row.getCell(10))) ? 1 : 0);
            statement.setInt(12, parseBoolean(formatter.formatCellValue(row.getCell(11))) ? 1 : 0);
            statement.setInt(13, parseBoolean(formatter.formatCellValue(row.getCell(12))) ? 1 : 0);
            statement.setInt(14, parseBoolean(formatter.formatCellValue(row.getCell(13))) ? 1 : 0);
            statement.setInt(15, parseBoolean(formatter.formatCellValue(row.getCell(14))) ? 1 : 0);
            statement.setInt(16, parseBoolean(formatter.formatCellValue(row.getCell(15))) ? 1 : 0);
            statement.setInt(17, parseBoolean(formatter.formatCellValue(row.getCell(16))) ? 1 : 0);
            statement.setInt(18, parseBoolean(formatter.formatCellValue(row.getCell(17))) ? 1 : 0);
            statement.setInt(19, parseBoolean(formatter.formatCellValue(row.getCell(18))) ? 1 : 0);
            statement.setInt(20, parseBoolean(formatter.formatCellValue(row.getCell(19))) ? 1 : 0);
            statement.setInt(21, parseBoolean(formatter.formatCellValue(row.getCell(20))) ? 1 : 0);
            statement.setString(22, formatter.formatCellValue(row.getCell(21)));
            statement.setString(23, formatter.formatCellValue(row.getCell(22)));
            statement.setString(24, formatter.formatCellValue(row.getCell(23)));
            statement.setString(25, formatter.formatCellValue(row.getCell(24)));

            statement.executeUpdate();
        }
    }

    private boolean parseBoolean(String value) {
        return "true".equalsIgnoreCase(value)
                || "1".equals(value)
                || "yes".equalsIgnoreCase(value)
                || "passed".equalsIgnoreCase(value);
    }
}
