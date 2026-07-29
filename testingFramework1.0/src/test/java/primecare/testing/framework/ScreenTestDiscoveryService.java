package primecare.testing.framework;

import primecare.testing.models.TestingLayerCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;

public class ScreenTestDiscoveryService {

    public static List<ScreenTestCaseDefinition> discoverTests(ScreenDefinition screen, TestingLayerCode layerCode) {
        List<ScreenTestCaseDefinition> discovered = new ArrayList<>();

        // 1. Discover baseline generated tests from database definitions
        discovered.addAll(discoverBaselineTests(screen, layerCode));

        // 2. Discover custom Java tests from the registry
        Optional<ScreenTestProvider> providerOpt = ScreenTestRegistry.findByScreenKey(screen.screenKey);
        if (providerOpt.isPresent()) {
            ScreenTestProvider provider = providerOpt.get();
            if (provider.getSupportedLayers().contains(layerCode)) {
                List<ScreenTestCaseDefinition> customTests = provider.getTestsForLayer(layerCode);
                if (customTests != null) {
                    for (ScreenTestCaseDefinition ct : customTests) {
                        ct.source = TestCaseSource.CUSTOM_CLASS;
                        discovered.add(ct);
                    }
                }
            }
        }

        return discovered;
    }

    private static List<ScreenTestCaseDefinition> discoverBaselineTests(ScreenDefinition screen, TestingLayerCode layerCode) {
        List<ScreenTestCaseDefinition> list = new ArrayList<>();
        String screenKey = screen.screenKey;
        int screenId = screen.screenId;

        switch (layerCode) {
            case L1:
                if (screen.route != null && !screen.route.isEmpty()) {
                    list.add(new ScreenTestCaseDefinition(
                        screenKey.toUpperCase() + "-L1-001",
                        "Verify route existence and load status for " + screen.screenName,
                        screenKey, TestingLayerCode.L1, 10, true, new HashSet<>(),
                        TestCaseSource.GENERATED, null
                    ));
                }
                break;
            case L2:
                // Query UI components
                String sqlComp = "SELECT * FROM ui_components WHERE screen_id = ? AND active = 1";
                try (Connection conn = SQLiteConnectionManager.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(sqlComp)) {
                    pstmt.setInt(1, screenId);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        int order = 10;
                        while (rs.next()) {
                            String key = rs.getString("component_key");
                            String name = rs.getString("component_name");
                            list.add(new ScreenTestCaseDefinition(
                                screenKey.toUpperCase() + "-L2-" + key.toUpperCase().replace("-", "_"),
                                "Verify component presence and state: " + name,
                                screenKey, TestingLayerCode.L2, order, true, new HashSet<>(),
                                TestCaseSource.GENERATED, null
                            ));
                            order += 10;
                        }
                    }
                } catch (Exception e) {
                    // Ignore
                }
                break;
            case L3:
                // Query UI functions
                String sqlFunc = "SELECT * FROM screen_functions WHERE screen_id = ? AND active = 1";
                try (Connection conn = SQLiteConnectionManager.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(sqlFunc)) {
                    pstmt.setInt(1, screenId);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        int order = 10;
                        while (rs.next()) {
                            String key = rs.getString("function_key");
                            String name = rs.getString("function_name");
                            list.add(new ScreenTestCaseDefinition(
                                screenKey.toUpperCase() + "-L3-" + key.toUpperCase().replace("-", "_"),
                                "Verify functional interaction: " + name,
                                screenKey, TestingLayerCode.L3, order, true, new HashSet<>(),
                                TestCaseSource.GENERATED, null
                            ));
                            order += 10;
                        }
                    }
                } catch (Exception e) {
                    // Ignore
                }
                break;
            case L5:
                // Query API test cases
                String sqlApi = "SELECT tc.*, ep.endpoint_key FROM api_test_cases tc " +
                                "JOIN api_endpoints ep ON ep.endpoint_id = tc.endpoint_id " +
                                "WHERE ep.endpoint_id IN (SELECT api_endpoint_key FROM screen_functions WHERE screen_id = ?)";
                // Let's also look up directly by screen's function references
                String sqlDirectApi = "SELECT tc.*, ep.endpoint_key FROM api_test_cases tc " +
                                      "JOIN api_endpoints ep ON ep.endpoint_id = tc.endpoint_id " +
                                      "JOIN screen_functions sf ON sf.api_endpoint_key = ep.endpoint_key " +
                                      "WHERE sf.screen_id = ? AND sf.active = 1";
                try (Connection conn = SQLiteConnectionManager.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(sqlDirectApi)) {
                    pstmt.setInt(1, screenId);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        int order = 10;
                        while (rs.next()) {
                            String key = rs.getString("test_case_key");
                            String name = rs.getString("test_case_name");
                            list.add(new ScreenTestCaseDefinition(
                                key,
                                "Verify API endpoint contract: " + name,
                                screenKey, TestingLayerCode.L5, order, true, new HashSet<>(),
                                TestCaseSource.DATABASE, null
                            ));
                            order += 10;
                        }
                    }
                } catch (Exception e) {
                    // Ignore
                }
                break;
            case L10:
                list.add(new ScreenTestCaseDefinition(
                    screenKey.toUpperCase() + "-L10-CERT",
                    "Compile certification readiness for " + screen.screenName,
                    screenKey, TestingLayerCode.L10, 10, true, new HashSet<>(),
                    TestCaseSource.GENERATED, null
                ));
                break;
        }

        return list;
    }
}

