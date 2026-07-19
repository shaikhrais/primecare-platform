package primecare.testing.framework.reporting;

import primecare.testing.framework.planning.TestPlan;
import primecare.testing.framework.planning.TestPlanItem;
import primecare.testing.framework.planning.ScreenTestCaseDefinition;

public class TestPlanConsoleReporter {

    public static void printPlan(TestPlan plan) {
        System.out.println("==================================================");
        System.out.println("TEST PLAN PREVIEW");
        System.out.println("Plan UUID: " + plan.planUuid);
        System.out.println("Execution Mode: " + plan.request.executionMode);
        System.out.println("Strategy: " + plan.request.executionStrategy);
        System.out.println("--------------------------------------------------");

        int totalItems = plan.items.size();
        int totalTestCases = 0;
        int executableLayers = 0;
        int notApplicableLayers = 0;

        for (TestPlanItem item : plan.items) {
            if (item.applicable) {
                executableLayers++;
            } else {
                notApplicableLayers++;
            }
            
            System.out.printf("Layer: %s | Screen: %s | Status: %s %s\n",
                item.layerCode,
                item.screenKey,
                item.status.name(),
                item.applicable ? "" : " (Reason: " + item.skipReason + ")"
            );

            if (item.testCases != null) {
                for (ScreenTestCaseDefinition tc : item.testCases) {
                    totalTestCases++;
                    System.out.printf("  └─ [%s] %s (Source: %s)\n",
                        tc.testCaseKey,
                        tc.testName,
                        tc.source
                    );
                }
            }
        }

        System.out.println("--------------------------------------------------");
        System.out.println("Total planned layers: " + totalItems);
        System.out.println("Executable layers: " + executableLayers);
        System.out.println("Not applicable layers: " + notApplicableLayers);
        System.out.println("Total test cases: " + totalTestCases);
        System.out.println("==================================================");
    }
}
