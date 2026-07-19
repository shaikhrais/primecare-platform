package base;

import java.sql.Connection;
import java.sql.PreparedStatement;

public final class SQLiteComponentResultRepository {

    private SQLiteComponentResultRepository() {
    }

    public static void save(
            ComponentVerificationResult result
    ) {

        String sql =
                """
                INSERT INTO component_verification (
                    screen_id,
                    page_name,
                    component_name,
                    component_type,
                    locator,
                    component_found,
                    component_visible,
                    component_enabled,
                    component_clickable,
                    verification_status,
                    failure_message,
                    verified_at
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
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
                    result.getScreenId()
            );

            statement.setString(
                    2,
                    result.getPageName()
            );

            statement.setString(
                    3,
                    result.getComponentName()
            );

            statement.setString(
                    4,
                    result.getComponentType()
            );

            statement.setString(
                    5,
                    result.getLocator()
            );

            statement.setInt(
                    6,
                    result.isFound() ? 1 : 0
            );

            statement.setInt(
                    7,
                    result.isVisible() ? 1 : 0
            );

            statement.setInt(
                    8,
                    result.isEnabled() ? 1 : 0
            );

            statement.setInt(
                    9,
                    result.isClickable() ? 1 : 0
            );

            statement.setString(
                    10,
                    result.getStatus()
            );

            statement.setString(
                    11,
                    result.getFailureMessage()
            );

            statement.executeUpdate();

        } catch (Exception exception) {

            throw new RuntimeException(
                    "Unable to save component result for: "
                            + result.getComponentName(),
                    exception
            );
        }
    }
}
