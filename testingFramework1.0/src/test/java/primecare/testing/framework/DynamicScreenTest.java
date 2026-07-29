package primecare.testing.framework;

import primecare.testing.base.BaseUiTest;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;

public class DynamicScreenTest extends BaseUiTest {
    public final TestPlanItem planItem;
    public final ScreenTestCaseDefinition testCase;

    public DynamicScreenTest(TestPlanItem planItem, ScreenTestCaseDefinition testCase) {
        this.planItem = planItem;
        this.testCase = testCase;
    }

    @Test
    public void execute() throws Exception {
        System.out.println("[RUNNER] Running test case: [" + testCase.screenKey + "][" + testCase.layerCode + "][" + testCase.testCaseKey + "] " + testCase.testName);

        if (!planItem.applicable) {
            System.out.println("[RUNNER] Skipping test case because layer is not applicable: " + planItem.skipReason);
            TestPlanItemRepository.updateItemStatus(planItem.planItemId, "NOT_APPLICABLE", null);
            throw new SkipException("NOT_APPLICABLE: " + planItem.skipReason);
        }

        boolean canExecute = LayerDependencyService.checkPredecessors(planItem.screenId, planItem.layerCode);
        if (!canExecute) {
            System.err.println("[RUNNER] Test case is BLOCKED by prior layer failures.");
            TestPlanItemRepository.updateItemStatus(planItem.planItemId, "BLOCKED", null);
            throw new SkipException("BLOCKED: Prior required layers have not passed.");
        }

        try {
            if (testCase.executor != null) {
                LayerExecutionResult result = testCase.executor.get();
                Assert.assertTrue(result.passed, result.message);
                if (result.error != null) {
                    throw new Exception(result.error);
                }
            } else {
                LayerTestExecutor executor = LayerTestExecutorRegistry.getExecutor(planItem.layerCode);
                executor.execute(driver, pageRecovery, planItem.screenId, planItem.screenKey);
            }

            System.out.println("[RUNNER] Test case PASSED: " + testCase.testCaseKey);
        } catch (Throwable t) {
            System.err.println("[RUNNER] Test case FAILED: " + testCase.testCaseKey + " due to: " + t.getMessage());
            throw new Exception(t);
        }
    }

    @Override
    public String toString() {
        return "[" + testCase.screenKey + "][" + testCase.layerCode + "][" + testCase.testCaseKey + "] " + testCase.testName;
    }
}

