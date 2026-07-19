package base;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public final class SQLiteVerificationDatabase {

    private static final String DATABASE_URL =
            "jdbc:sqlite:c:/Users/Admin2/Documents/GitHub/"
                    + "primecare-platform/.agents/governance/"
                    + "governance.db";

    private SQLiteVerificationDatabase() {
    }

    public static Connection getConnection()
            throws SQLException {

        return DriverManager.getConnection(DATABASE_URL);
    }

    public static void createTables() {

        String createTestRunTable =
                """
                CREATE TABLE IF NOT EXISTS test_run (
                    run_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    suite_name TEXT,
                    started_at TEXT,
                    completed_at TEXT,
                    total_tests INTEGER DEFAULT 0,
                    passed_tests INTEGER DEFAULT 0,
                    failed_tests INTEGER DEFAULT 0,
                    skipped_tests INTEGER DEFAULT 0,
                    excel_file_path TEXT,
                    import_status TEXT DEFAULT 'NOT_IMPORTED'
                )
                """;

        String createTestResultTable =
                """
                CREATE TABLE IF NOT EXISTS test_case_result (
                    result_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id INTEGER,
                    screen_id INTEGER,
                    test_class TEXT,
                    test_method TEXT,
                    expected_page TEXT,
                    actual_page TEXT,
                    expected_route TEXT,
                    actual_url TEXT,
                    route_verified INTEGER DEFAULT 0,
                    page_verified INTEGER DEFAULT 0,
                    component_verified INTEGER DEFAULT 0,
                    error_page_found INTEGER DEFAULT 0,
                    test_status TEXT,
                    failure_message TEXT,
                    execution_time_ms INTEGER DEFAULT 0,
                    verified_at TEXT DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (run_id) REFERENCES test_run(run_id)
                )
                """;

        String createScreenVerificationTable =
                """
                CREATE TABLE IF NOT EXISTS screen_verification (
                    screen_id INTEGER PRIMARY KEY,
                    expected_title TEXT,
                    expected_route TEXT,
                    actual_title TEXT,
                    actual_url TEXT,
                    route_loaded INTEGER DEFAULT 0,
                    page_verified INTEGER DEFAULT 0,
                    sidebar_found INTEGER DEFAULT 0,
                    topbar_found INTEGER DEFAULT 0,
                    main_content_found INTEGER DEFAULT 0,
                    component_verified INTEGER DEFAULT 0,
                    placeholder_found INTEGER DEFAULT 0,
                    error_page_found INTEGER DEFAULT 0,
                    final_status TEXT DEFAULT 'NOT_TESTED',
                    failure_message TEXT,
                    screenshot_path TEXT,
                    last_test_run_id INTEGER,
                    verified_at TEXT
                )
                """;

        String createImportLogTable =
                """
                CREATE TABLE IF NOT EXISTS excel_import_log (
                    import_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id INTEGER,
                    excel_file_path TEXT,
                    rows_read INTEGER DEFAULT 0,
                    rows_inserted INTEGER DEFAULT 0,
                    rows_updated INTEGER DEFAULT 0,
                    rows_failed INTEGER DEFAULT 0,
                    import_status TEXT,
                    error_message TEXT,
                    imported_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
                """;

        String createComponentResultTable =
                """
                CREATE TABLE IF NOT EXISTS component_verification (
                    component_result_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    screen_id INTEGER,
                    page_name TEXT,
                    component_name TEXT,
                    component_type TEXT,
                    locator TEXT,
                    component_found INTEGER DEFAULT 0,
                    component_visible INTEGER DEFAULT 0,
                    component_enabled INTEGER DEFAULT 0,
                    component_clickable INTEGER DEFAULT 0,
                    verification_status TEXT,
                    failure_message TEXT,
                    verified_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
                """;

        String createFunctionalResultTable =
                """
                CREATE TABLE IF NOT EXISTS functional_verification (
                    functional_result_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    screen_id INTEGER,
                    page_name TEXT,
                    test_class TEXT,
                    test_status TEXT,
                    failure_message TEXT,
                    execution_time_ms INTEGER DEFAULT 0,
                    verified_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
                """;

        String createNavigationRecoveryTable =
                """
                CREATE TABLE IF NOT EXISTS navigation_recovery (
                    recovery_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id INTEGER,
                    screen_id INTEGER,
                    requested_url TEXT,
                    expected_route TEXT,
                    expected_page TEXT,
                    actual_url TEXT,
                    actual_page TEXT,
                    browser_title TEXT,
                    attempt_count INTEGER DEFAULT 0,
                    language_page_detected INTEGER DEFAULT 0,
                    language_selection_succeeded INTEGER DEFAULT 0,
                    login_page_detected INTEGER DEFAULT 0,
                    login_succeeded INTEGER DEFAULT 0,
                    route_verified INTEGER DEFAULT 0,
                    title_verified INTEGER DEFAULT 0,
                    page_marker_verified INTEGER DEFAULT 0,
                    main_content_verified INTEGER DEFAULT 0,
                    error_page_detected INTEGER DEFAULT 0,
                    access_denied INTEGER DEFAULT 0,
                    resource_busy INTEGER DEFAULT 0,
                    resource_not_found INTEGER DEFAULT 0,
                    failure_type TEXT,
                    failure_message TEXT,
                    screenshot_path TEXT,
                    final_status TEXT,
                    verified_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
                """;

        try (
                Connection connection = getConnection();
                Statement statement = connection.createStatement()
        ) {
            statement.execute(createTestRunTable);
            statement.execute(createTestResultTable);
            statement.execute(createScreenVerificationTable);
            statement.execute(createImportLogTable);
            statement.execute(createComponentResultTable);
            statement.execute(createFunctionalResultTable);
            statement.execute(createNavigationRecoveryTable);

            System.out.println(
                    "[SQLITE] Verification tables created successfully."
            );

        } catch (SQLException exception) {

            throw new RuntimeException(
                    "Unable to create SQLite verification tables.",
                    exception
            );
        }
    }

    public static void initializeDatabase() {
        try (
                Connection connection = getConnection();
                Statement statement = connection.createStatement()
        ) {
            statement.execute("DROP TABLE IF EXISTS test_run;");
            statement.execute("DROP TABLE IF EXISTS test_case_result;");
            statement.execute("DROP TABLE IF EXISTS screen_verification;");
            statement.execute("DROP TABLE IF EXISTS excel_import_log;");
            statement.execute("DROP TABLE IF EXISTS component_verification;");
            statement.execute("DROP TABLE IF EXISTS functional_verification;");
            statement.execute("DROP TABLE IF EXISTS navigation_recovery;");
        } catch (SQLException exception) {
            throw new RuntimeException("Unable to initialize SQLite database.", exception);
        }
        createTables();
    }
}
