package primecare.testing.framework;

import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ScreenSelectionService {

    public static List<ScreenDefinition> selectScreens(String screenKey, Long screenId, String moduleName) {
        List<ScreenDefinition> list = new ArrayList<>();

        if (screenId != null) {
            String sql = "SELECT * FROM screens WHERE screen_id = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setLong(1, screenId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        list.add(mapScreen(rs));
                    }
                }
            } catch (Exception e) {
                System.err.println("[SCREEN SELECT] Error: " + e.getMessage());
            }
        } else if (screenKey != null && !"*".equals(screenKey)) {
            ScreenDefinition screen = ScreenRepository.getScreenByKey(screenKey);
            if (screen != null) {
                list.add(screen);
            }
        } else if (moduleName != null) {
            String sql = "SELECT * FROM screens WHERE module_name = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, moduleName);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapScreen(rs));
                    }
                }
            } catch (Exception e) {
                System.err.println("[SCREEN SELECT] Error: " + e.getMessage());
            }
        } else {
            list = ScreenRepository.getScreens();
        }

        if (list.isEmpty()) {
            throw new IllegalArgumentException("DefinitionNotFoundException: No active screens found matching screenKey=" + screenKey + ", screenId=" + screenId + ", moduleName=" + moduleName);
        }

        return list;
    }

    private static ScreenDefinition mapScreen(ResultSet rs) throws Exception {
        ScreenDefinition s = new ScreenDefinition();
        s.screenId = rs.getInt("screen_id");
        s.applicationId = rs.getInt("application_id");
        s.screenKey = rs.getString("screen_key");
        s.screenName = rs.getString("screen_name");
        s.route = rs.getString("route");
        s.pageClass = rs.getString("page_class");
        s.moduleName = rs.getString("module_name");
        s.requiredRole = rs.getString("required_role");
        s.implementationStatus = rs.getString("implementation_status");
        s.verificationStatus = rs.getString("verification_status");
        s.active = rs.getInt("active") == 1;
        s.createdAt = rs.getString("created_at");
        s.updatedAt = rs.getString("updated_at");
        return s;
    }
}

