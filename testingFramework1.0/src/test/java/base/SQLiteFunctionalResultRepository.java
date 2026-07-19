package base;

import java.sql.Connection;
import java.sql.PreparedStatement;

public final class SQLiteFunctionalResultRepository {

    private SQLiteFunctionalResultRepository() {
    }

    public static void save(
            int screenId,
            String pageName,
            String testClass,
            String status,
            String failureMessage,
            long executionTimeMs
    ) {

        String sql =
                """
                INSERT INTO functional_verification (
                    screen_id,
                    page_name,
                    test_class,
                    test_status,
                    failure_message,
                    execution_time_ms,
                    verified_at
                )
                VALUES (?, ?, ?, ?, ?, ?, datetime('now'))
                """;

        try (
                Connection connection =
                        SQLiteVerificationDatabase
                                .getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    screenId
            );

            statement.setString(
                    2,
                    pageName
            );

            statement.setString(
                    3,
                    testClass
            );

            statement.setString(
                    4,
                    status
            );

            statement.setString(
                    5,
                    failureMessage
            );

            statement.setLong(
                    6,
                    executionTimeMs
            );

            statement.executeUpdate();

        } catch (Exception exception) {

            throw new RuntimeException(
                    "Unable to save functional test result.",
                    exception
            );
        }
    }
}
