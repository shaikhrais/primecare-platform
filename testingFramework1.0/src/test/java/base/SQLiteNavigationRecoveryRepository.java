package base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public final class SQLiteNavigationRecoveryRepository {

    private SQLiteNavigationRecoveryRepository() {
    }

    public static void save(
            NavigationRecoveryResult result
    ) {

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
                Connection connection =
                        SQLiteVerificationDatabase
                                .getConnection()
        ) {

            long runId = getLatestRunId(connection);

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                if (runId > 0) {
                    statement.setLong(1, runId);
                } else {
                    statement.setNull(1, java.sql.Types.INTEGER);
                }

                // Temporary screenId placeholder or extract if possible
                statement.setInt(2, 0); 
                statement.setString(3, result.getRequestedUrl());
                statement.setString(4, result.getExpectedRoute());
                statement.setString(5, result.getExpectedPage());
                statement.setString(6, result.getActualUrl());
                statement.setString(7, result.getActualPage());
                statement.setString(8, result.getBrowserTitle());
                statement.setInt(9, result.getAttempts());
                statement.setInt(10, result.isLanguagePageDetected() ? 1 : 0);
                statement.setInt(11, result.isLanguageSelectionSucceeded() ? 1 : 0);
                statement.setInt(12, result.isLoginPageDetected() ? 1 : 0);
                statement.setInt(13, result.isLoginSucceeded() ? 1 : 0);
                statement.setInt(14, result.isRouteVerified() ? 1 : 0);
                statement.setInt(15, result.isTitleVerified() ? 1 : 0);
                statement.setInt(16, result.isPageMarkerVerified() ? 1 : 0);
                statement.setInt(17, result.isMainContentVerified() ? 1 : 0);
                statement.setInt(18, result.isErrorPageDetected() ? 1 : 0);
                statement.setInt(19, result.isAccessDenied() ? 1 : 0);
                statement.setInt(20, result.isResourceBusy() ? 1 : 0);
                statement.setInt(21, result.isResourceNotFound() ? 1 : 0);
                statement.setString(22, result.getFailureType());
                statement.setString(23, result.getFailureMessage());
                statement.setString(24, result.getScreenshotPath());
                statement.setString(25, result.isSuccessful() ? "SUCCESS" : "FAILURE");

                statement.executeUpdate();
            }

        } catch (Exception exception) {
            System.err.println("Unable to save navigation recovery result: " + exception.getMessage());
        }
    }

    private static long getLatestRunId(Connection connection) {
        String sql = "SELECT run_id FROM test_run ORDER BY run_id DESC LIMIT 1";
        try (
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql)
        ) {
            if (resultSet.next()) {
                return resultSet.getLong("run_id");
            }
        } catch (Exception ignored) {
        }
        return 0L;
    }
}
