package primecare.testing.framework.planning;

import primecare.testing.framework.database.SQLiteConnectionManager;
import primecare.testing.framework.planning.Models.ScreenDefinition;
import primecare.testing.models.TestingLayerCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LayerApplicabilityService {

    public static class ApplicabilityResult {
        public final boolean isApplicable;
        public final String reason;

        public ApplicabilityResult(boolean isApplicable, String reason) {
            this.isApplicable = isApplicable;
            this.reason = reason;
        }
    }

    public static ApplicabilityResult checkApplicability(ScreenDefinition screen, TestingLayerCode layerCode) {
        switch (layerCode) {
            case L1:
                boolean hasRoute = screen.route != null && !screen.route.isEmpty();
                return new ApplicabilityResult(hasRoute, hasRoute ? "Screen has registered route." : "Screen has no route.");
            case L2:
                boolean hasComponents = getCount("SELECT COUNT(*) FROM ui_components WHERE screen_id = ? AND active = 1", screen.screenId) > 0;
                return new ApplicabilityResult(hasComponents, hasComponents ? "Screen has registered UI components." : "Screen has no UI components.");
            case L3:
                boolean hasFunctions = getCount("SELECT COUNT(*) FROM screen_functions WHERE screen_id = ? AND active = 1", screen.screenId) > 0;
                return new ApplicabilityResult(hasFunctions, hasFunctions ? "Screen has registered UI functions." : "Screen has no UI functions.");
            case L4:
                boolean hasRules = getCount("SELECT COUNT(*) FROM screen_functions WHERE screen_id = ? AND business_rule_key IS NOT NULL AND active = 1", screen.screenId) > 0;
                return new ApplicabilityResult(hasRules, hasRules ? "Screen functions map to business rules." : "Screen functions do not map to business rules.");
            case L5:
                boolean hasApis = getCount("SELECT COUNT(*) FROM screen_functions WHERE screen_id = ? AND api_endpoint_key IS NOT NULL AND active = 1", screen.screenId) > 0;
                return new ApplicabilityResult(hasApis, hasApis ? "Screen functions reference API endpoints." : "Screen functions do not reference API endpoints.");
            case L6:
                boolean hasIntegrations = getCount("SELECT COUNT(*) FROM integration_mappings WHERE screen_id = ? AND active = 1", screen.screenId) > 0;
                return new ApplicabilityResult(hasIntegrations, hasIntegrations ? "Screen has UI/API integration mappings." : "Screen has no UI/API integration mappings.");
            case L7:
                boolean hasDbRules = getCount("SELECT COUNT(*) FROM screen_functions WHERE screen_id = ? AND database_validation_key IS NOT NULL AND active = 1", screen.screenId) > 0;
                return new ApplicabilityResult(hasDbRules, hasDbRules ? "Screen functions reference database validation keys." : "Screen functions do not map to database validations.");
            case L8:
                boolean hasRbac = screen.requiredRole != null && !screen.requiredRole.isEmpty() && !"ANY".equalsIgnoreCase(screen.requiredRole);
                return new ApplicabilityResult(hasRbac, hasRbac ? "Screen has required role constraints." : "Screen has no specific role restrictions.");
            case L9:
                boolean hasWorkflows = getCount("SELECT COUNT(*) FROM workflow_steps WHERE screen_key = ? OR function_key IN (SELECT function_key FROM screen_functions WHERE screen_id = ?)", screen.screenKey, screen.screenId) > 0;
                return new ApplicabilityResult(hasWorkflows, hasWorkflows ? "Screen is part of end-to-end workflow steps." : "Screen does not participate in workflows.");
            case L10:
                return new ApplicabilityResult(true, "Screen is subject to final certification audit.");
            default:
                return new ApplicabilityResult(false, "Unknown layer.");
        }
    }

    private static int getCount(String sql, Object... params) {
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.err.println("[APPLICABILITY] Error getting count: " + e.getMessage());
        }
        return 0;
    }
}
