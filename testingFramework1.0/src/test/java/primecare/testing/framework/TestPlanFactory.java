package primecare.testing.framework;

import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import primecare.testing.models.TestingLayerCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.Instant;
import java.util.*;

public class TestPlanFactory {

    public static TestPlan createPlan(TestExecutionRequest request) {
        System.out.println("[PLANNER] Creating Test Plan for request...");
        TestPlan plan = new TestPlan();
        plan.planUuid = UUID.randomUUID().toString();
        plan.request = request;
        plan.createdAt = Instant.now();
        plan.items = new ArrayList<>();

        // 1. Select Screens
        List<ScreenDefinition> screens = ScreenSelectionService.selectScreens(
            request.screenKey, request.screenId, request.moduleName
        );

        // 2. Select base layers
        Set<TestingLayerCode> targetLayers = LayerSelectionService.resolveLayers(request);
        
        // 3. Expand dependencies
        Set<TestingLayerCode> resolvedLayers = DependencyExpansionService.expandDependencies(
            targetLayers, request.includeDependencies
        );

        // 4. Create Plan Items (screen + layer combination)
        for (ScreenDefinition screen : screens) {
            for (TestingLayerCode layerCode : resolvedLayers) {
                TestPlanItem item = new TestPlanItem();
                item.planItemUuid = UUID.randomUUID().toString();
                item.screenId = screen.screenId;
                item.screenKey = screen.screenKey;
                item.layerCode = layerCode;
                
                // Determine applicability
                LayerApplicabilityService.ApplicabilityResult appResult = LayerApplicabilityService.checkApplicability(screen, layerCode);
                item.applicable = appResult.isApplicable;
                if (!item.applicable) {
                    item.skipReason = appResult.reason;
                    item.status = TestPlanItemStatus.NOT_APPLICABLE;
                } else {
                    item.status = TestPlanItemStatus.PLANNED;
                }

                // Determine if required
                item.required = isLayerRequired(screen.screenId, layerCode.ordinal() + 1);

                // Predecessor dependencies
                Set<TestingLayerCode> deps = new HashSet<>();
                for (int i = 0; i < layerCode.ordinal(); i++) {
                    deps.add(TestingLayerCode.values()[i]);
                }
                item.dependencies = deps;

                // Discover & merge tests for this screen and layer (Round 2 addition)
                List<ScreenTestCaseDefinition> discovered = ScreenTestDiscoveryService.discoverTests(screen, layerCode);
                item.testCases = ScreenTestMergeService.mergeTests(discovered);

                // If layer is applicable but has zero registered tests, mark NOT_APPLICABLE or empty
                if (item.applicable && item.testCases.isEmpty()) {
                    item.applicable = false;
                    item.skipReason = "No registered tests found in database or custom classes.";
                    item.status = TestPlanItemStatus.NOT_APPLICABLE;
                }

                plan.items.add(item);
            }
        }

        // 5. Sort Plan Items according to strategy
        sortPlanItems(plan.items, request.executionStrategy);

        // Assign execution orders
        for (int i = 0; i < plan.items.size(); i++) {
            plan.items.get(i).executionOrder = i + 1;
        }

        // 6. Save Plan in SQLite if not dry-run
        TestPlanRepository.insertPlan(plan);
        for (TestPlanItem item : plan.items) {
            item.planId = plan.planId;
            TestPlanItemRepository.insertPlanItem(item);
        }

        System.out.println("[PLANNER] Test Plan generated: " + plan.planUuid + " with " + plan.items.size() + " items.");
        return plan;
    }

    private static boolean isLayerRequired(int screenId, int layerId) {
        String sql = "SELECT required FROM screen_layer_requirements WHERE screen_id = ? AND layer_id = ?";
        try (Connection conn = SQLiteConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, screenId);
            pstmt.setInt(2, layerId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("required") == 1;
                }
            }
        } catch (Exception e) {
            // Default to true
        }
        return true;
    }

    private static void sortPlanItems(List<TestPlanItem> items, ExecutionStrategy strategy) {
        if (strategy == ExecutionStrategy.LAYER_FIRST) {
            Collections.sort(items, (a, b) -> {
                int cmp = Integer.compare(a.layerCode.ordinal(), b.layerCode.ordinal());
                if (cmp != 0) return cmp;
                return a.screenKey.compareTo(b.screenKey);
            });
        } else {
            Collections.sort(items, (a, b) -> {
                int cmp = a.screenKey.compareTo(b.screenKey);
                if (cmp != 0) return cmp;
                return Integer.compare(a.layerCode.ordinal(), b.layerCode.ordinal());
            });
        }
    }
}

