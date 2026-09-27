package primecare.testing.framework;

import static primecare.testing.framework.LayerExecutors.*;

import primecare.testing.models.TestingLayerCode;

import java.util.HashMap;
import java.util.Map;

public class LayerTestExecutorRegistry {
    private static final Map<TestingLayerCode, LayerTestExecutor> registry = new HashMap<>();

    static {
        register(new L1RouteTestExecutor());
        register(new L2ComponentTestExecutor());
        register(new L3FunctionalTestExecutor());
        register(new L4BusinessLogicTestExecutor());
        register(new L5ApiEndpointTestExecutor());
        register(new L6IntegrationTestExecutor());
        register(new L7DatabaseFlowTestExecutor());
        register(new L8SecurityTestExecutor());
        register(new L9WorkflowTestExecutor());
        register(new L10GovernanceTestExecutor());
    }

    private static void register(LayerTestExecutor executor) {
        registry.put(executor.supports(), executor);
    }

    public static LayerTestExecutor getExecutor(TestingLayerCode code) {
        LayerTestExecutor executor = registry.get(code);
        if (executor == null) {
            throw new RuntimeException("No executor registered for testing layer: " + code);
        }
        return executor;
    }
}

