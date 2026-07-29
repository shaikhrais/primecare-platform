package primecare.testing.listeners;

import primecare.testing.base.BaseTest;
import primecare.testing.framework.Models.*;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.LayerDependencyService;
import primecare.testing.framework.LayerDependencyService.DependencyResult;
import primecare.testing.validation.TestLayer;
import org.testng.IInvokedMethod;
import org.testng.IInvokedMethodListener;
import org.testng.ITestResult;
import org.testng.SkipException;

public class DependencyListener implements IInvokedMethodListener {

    @Override
    public void beforeInvocation(IInvokedMethod method, ITestResult testResult) {
        if (!method.isTestMethod()) return;
        if (BaseTest.executionId == -1) return;

        // Resolve Layer
        int layerId = resolveLayer(method);
        if (layerId == 1) return; // L1 has no predecessor dependencies

        // Resolve Screen/Endpoint/Workflow
        Integer screenId = null;
        Integer endpointId = null;
        Integer workflowId = null;

        Object[] params = testResult.getParameters();
        if (params != null && params.length > 0) {
            for (Object param : params) {
                if (param instanceof ScreenDefinition) {
                    screenId = ((ScreenDefinition) param).screenId;
                } else if (param instanceof UiComponentDefinition) {
                    screenId = ((UiComponentDefinition) param).screenId;
                } else if (param instanceof ScreenFunctionDefinition) {
                    screenId = ((ScreenFunctionDefinition) param).screenId;
                } else if (param instanceof ApiEndpointDefinition) {
                    endpointId = ((ApiEndpointDefinition) param).endpointId;
                } else if (param instanceof ApiTestCaseDefinition) {
                    endpointId = ((ApiTestCaseDefinition) param).endpointId;
                } else if (param instanceof WorkflowDefinition) {
                    workflowId = ((WorkflowDefinition) param).workflowId;
                }
            }
        }

        // If screenId, endpointId, and workflowId are all null, check if we can skip dependency check
        if (screenId == null && endpointId == null && workflowId == null) {
            return;
        }

        DependencyResult depResult = LayerDependencyService.checkDependency(
            BaseTest.executionId, layerId, screenId, endpointId, workflowId
        );

        if (!depResult.isExecutable) {
            String blockMsg = "BLOCKED: " + depResult.reason;
            if (depResult.blockingResultId != null) {
                blockMsg += " | BLOCKING_RESULT_ID:" + depResult.blockingResultId;
            }
            throw new SkipException(blockMsg);
        }
    }

    private int resolveLayer(IInvokedMethod method) {
        TestLayer anno = method.getTestMethod().getConstructorOrMethod().getMethod().getAnnotation(TestLayer.class);
        if (anno == null) {
            anno = method.getTestMethod().getTestClass().getRealClass().getAnnotation(TestLayer.class);
        }
        if (anno != null) {
            return anno.value().ordinal() + 1;
        }

        String pkg = method.getTestMethod().getTestClass().getRealClass().getPackageName();
        if (pkg.contains(".l1")) return 1;
        if (pkg.contains(".l2")) return 2;
        if (pkg.contains(".l3")) return 3;
        if (pkg.contains(".l4")) return 4;
        if (pkg.contains(".l5")) return 5;
        if (pkg.contains(".l6")) return 6;
        if (pkg.contains(".l7")) return 7;
        if (pkg.contains(".l8")) return 8;
        if (pkg.contains(".l9")) return 9;
        if (pkg.contains(".l10")) return 10;

        return 1;
    }

    @Override
    public void afterInvocation(IInvokedMethod method, ITestResult testResult) {}
}

