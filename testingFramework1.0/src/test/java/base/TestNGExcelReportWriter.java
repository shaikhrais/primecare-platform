package base;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public final class TestNGExcelReportWriter {

    private static final List<VerificationResult> RESULTS =
            new ArrayList<>();

    private static final List<ComponentVerificationResult>
            COMPONENT_RESULTS =
                    new ArrayList<>();

    private static final List<NavigationRecoveryResult>
            NAVIGATION_RECOVERY_RESULTS =
                    new ArrayList<>();

    private TestNGExcelReportWriter() {
    }

    public static synchronized void addResult(
            VerificationResult result
    ) {

        RESULTS.add(result);
    }

    public static synchronized void addComponentResult(
            ComponentVerificationResult result
    ) {
        COMPONENT_RESULTS.add(result);
    }

    public static synchronized void addNavigationRecoveryResult(
            NavigationRecoveryResult result
    ) {
        NAVIGATION_RECOVERY_RESULTS.add(result);
    }

    public static synchronized String createExcelReport(
            String outputDirectory
    ) {

        File directory =
                new File(outputDirectory);

        if (!directory.exists()
                && !directory.mkdirs()) {

            throw new IllegalStateException(
                    "Unable to create report directory: "
                            + outputDirectory
            );
        }

        String fileName =
                "PrimeCare_TestNG_Verification_"
                        + System.currentTimeMillis()
                        + ".xlsx";

        File reportFile =
                new File(directory, fileName);

        try (
                XSSFWorkbook workbook =
                        new XSSFWorkbook();

                FileOutputStream outputStream =
                        new FileOutputStream(reportFile)
        ) {

            Sheet sheet =
                    workbook.createSheet(
                            "Screen Verification"
                    );

            CellStyle headerStyle =
                    workbook.createCellStyle();

            Font headerFont =
                    workbook.createFont();

            headerFont.setBold(true);
            headerStyle.setFont(headerFont);

            String[] headers = {
                    "Screen ID",
                    "Test Class",
                    "Test Method",
                    "Expected Page",
                    "Actual Page",
                    "Expected Route",
                    "Actual URL",
                    "Route Verified",
                    "Page Verified",
                    "Component Verified",
                    "Error Page Found",
                    "Test Status",
                    "Failure Message",
                    "Execution Time MS",
                    "Verified At"
            };

            Row headerRow =
                    sheet.createRow(0);

            for (
                    int column = 0;
                    column < headers.length;
                    column++
            ) {

                headerRow
                        .createCell(column)
                        .setCellValue(headers[column]);

                headerRow
                        .getCell(column)
                        .setCellStyle(headerStyle);
            }

            int rowIndex = 1;

            for (
                    VerificationResult result :
                    RESULTS
            ) {

                Row row =
                        sheet.createRow(rowIndex++);

                row.createCell(0)
                        .setCellValue(result.getScreenId());

                row.createCell(1)
                        .setCellValue(result.getTestClass());

                row.createCell(2)
                        .setCellValue(result.getTestMethod());

                row.createCell(3)
                        .setCellValue(result.getExpectedPage());

                row.createCell(4)
                        .setCellValue(result.getActualPage());

                row.createCell(5)
                        .setCellValue(result.getExpectedRoute());

                row.createCell(6)
                        .setCellValue(result.getActualUrl());

                row.createCell(7)
                        .setCellValue(result.isRouteVerified());

                row.createCell(8)
                        .setCellValue(result.isPageVerified());

                row.createCell(9)
                        .setCellValue(result.isComponentVerified());

                row.createCell(10)
                        .setCellValue(result.isErrorPageFound());

                row.createCell(11)
                        .setCellValue(result.getTestStatus());

                row.createCell(12)
                        .setCellValue(
                                result.getFailureMessage() == null
                                        ? ""
                                        : result.getFailureMessage()
                        );

                row.createCell(13)
                        .setCellValue(result.getExecutionTimeMs());

                row.createCell(14)
                        .setCellValue(
                                LocalDateTime.now().toString()
                        );
            }

            for (
                    int column = 0;
                    column < headers.length;
                    column++
            ) {

                sheet.autoSizeColumn(column);
            }

            // Create Component Verification sheet
            Sheet componentSheet =
                    workbook.createSheet(
                            "Component Verification"
                    );

            String[] componentHeaders = {
                    "Screen ID",
                    "Page Name",
                    "Component Name",
                    "Component Type",
                    "Locator",
                    "Found",
                    "Visible",
                    "Enabled",
                    "Clickable",
                    "Status",
                    "Failure Message"
            };

            Row componentHeader =
                    componentSheet.createRow(0);

            for (
                    int column = 0;
                    column < componentHeaders.length;
                    column++
            ) {

                componentHeader
                        .createCell(column)
                        .setCellValue(
                                componentHeaders[column]
                        );

                componentHeader
                        .getCell(column)
                        .setCellStyle(headerStyle);
            }

            int componentRowIndex = 1;

            for (
                    ComponentVerificationResult result :
                    COMPONENT_RESULTS
            ) {

                Row row =
                        componentSheet.createRow(
                                componentRowIndex++
                        );

                row.createCell(0)
                        .setCellValue(
                                result.getScreenId()
                        );

                row.createCell(1)
                        .setCellValue(
                                result.getPageName()
                        );

                row.createCell(2)
                        .setCellValue(
                                result.getComponentName()
                        );

                row.createCell(3)
                        .setCellValue(
                                result.getComponentType()
                        );

                row.createCell(4)
                        .setCellValue(
                                result.getLocator()
                        );

                row.createCell(5)
                        .setCellValue(
                                result.isFound()
                        );

                row.createCell(6)
                        .setCellValue(
                                result.isVisible()
                        );

                row.createCell(7)
                        .setCellValue(
                                result.isEnabled()
                        );

                row.createCell(8)
                        .setCellValue(
                                result.isClickable()
                        );

                row.createCell(9)
                        .setCellValue(
                                result.getStatus()
                        );

                row.createCell(10)
                        .setCellValue(
                                result.getFailureMessage() == null
                                        ? ""
                                        : result.getFailureMessage()
                        );
            }

            for (
                    int column = 0;
                    column < componentHeaders.length;
                    column++
            ) {

                componentSheet.autoSizeColumn(
                        column
                );
            }

            // Create Navigation Recovery sheet
            Sheet recoverySheet =
                    workbook.createSheet(
                            "Navigation Recovery"
                    );

            String[] recoveryHeaders = {
                    "Run ID",
                    "Screen ID",
                    "Requested URL",
                    "Expected Route",
                    "Expected Page",
                    "Actual URL",
                    "Actual Page",
                    "Browser Title",
                    "Attempt Count",
                    "Language Page Detected",
                    "Language Selection Succeeded",
                    "Login Page Detected",
                    "Login Succeeded",
                    "Route Verified",
                    "Title Verified",
                    "Page Marker Verified",
                    "Main Content Verified",
                    "Error Page Detected",
                    "Access Denied",
                    "Resource Busy",
                    "Resource Not Found",
                    "Failure Type",
                    "Failure Message",
                    "Screenshot Path",
                    "Final Status",
                    "Verified At"
            };

            Row recoveryHeader =
                    recoverySheet.createRow(0);

            for (
                    int column = 0;
                    column < recoveryHeaders.length;
                    column++
            ) {

                recoveryHeader
                        .createCell(column)
                        .setCellValue(
                                recoveryHeaders[column]
                        );

                recoveryHeader
                        .getCell(column)
                        .setCellStyle(headerStyle);
            }

            int recoveryRowIndex = 1;

            for (
                    NavigationRecoveryResult result :
                    NAVIGATION_RECOVERY_RESULTS
            ) {

                Row row =
                        recoverySheet.createRow(
                                recoveryRowIndex++
                        );

                row.createCell(0)
                        .setCellValue(
                                0 // Run ID placeholder
                        );

                row.createCell(1)
                        .setCellValue(
                                0 // Screen ID placeholder
                        );

                row.createCell(2)
                        .setCellValue(
                                result.getRequestedUrl()
                        );

                row.createCell(3)
                        .setCellValue(
                                result.getExpectedRoute()
                        );

                row.createCell(4)
                        .setCellValue(
                                result.getExpectedPage()
                        );

                row.createCell(5)
                        .setCellValue(
                                result.getActualUrl()
                        );

                row.createCell(6)
                        .setCellValue(
                                result.getActualPage()
                        );

                row.createCell(7)
                        .setCellValue(
                                result.getBrowserTitle()
                        );

                row.createCell(8)
                        .setCellValue(
                                result.getAttempts()
                        );

                row.createCell(9)
                        .setCellValue(
                                result.isLanguagePageDetected()
                        );

                row.createCell(10)
                        .setCellValue(
                                result.isLanguageSelectionSucceeded()
                        );

                row.createCell(11)
                        .setCellValue(
                                result.isLoginPageDetected()
                        );

                row.createCell(12)
                        .setCellValue(
                                result.isLoginSucceeded()
                        );

                row.createCell(13)
                        .setCellValue(
                                result.isRouteVerified()
                        );

                row.createCell(14)
                        .setCellValue(
                                result.isTitleVerified()
                        );

                row.createCell(15)
                        .setCellValue(
                                result.isPageMarkerVerified()
                        );

                row.createCell(16)
                        .setCellValue(
                                result.isMainContentVerified()
                        );

                row.createCell(17)
                        .setCellValue(
                                result.isErrorPageDetected()
                        );

                row.createCell(18)
                        .setCellValue(
                                result.isAccessDenied()
                        );

                row.createCell(19)
                        .setCellValue(
                                result.isResourceBusy()
                        );

                row.createCell(20)
                        .setCellValue(
                                result.isResourceNotFound()
                        );

                row.createCell(21)
                        .setCellValue(
                                result.getFailureType()
                        );

                row.createCell(22)
                        .setCellValue(
                                result.getFailureMessage() == null
                                        ? ""
                                        : result.getFailureMessage()
                        );

                row.createCell(23)
                        .setCellValue(
                                result.getScreenshotPath() == null
                                        ? ""
                                        : result.getScreenshotPath()
                        );

                row.createCell(24)
                        .setCellValue(
                                result.isSuccessful() ? "SUCCESS" : "FAILURE"
                        );

                row.createCell(25)
                        .setCellValue(
                                LocalDateTime.now().toString()
                        );
            }

            for (
                    int column = 0;
                    column < recoveryHeaders.length;
                    column++
            ) {

                recoverySheet.autoSizeColumn(
                        column
                );
            }

            workbook.write(outputStream);

            System.out.println(
                    "[EXCEL] TestNG report created: "
                            + reportFile.getAbsolutePath()
            );

            return reportFile.getAbsolutePath();

        } catch (IOException exception) {

            throw new RuntimeException(
                    "Unable to create TestNG Excel report.",
                    exception
            );
        }
    }
}
