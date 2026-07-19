package primecare.testing.framework.planning;

import primecare.testing.models.TestingLayerCode;
import java.util.Set;
import java.util.function.Supplier;

public final class ScreenTestCaseDefinition {
    public String testCaseKey;
    public String testName;
    public String screenKey;
    public TestingLayerCode layerCode;
    public int executionOrder;
    public boolean required;
    public Set<TestingLayerCode> dependencies;
    public TestCaseSource source;
    public Supplier<LayerExecutionResult> executor;
    public String testClass;
    public String testMethod;
    public String tags;
    public String description;

    public ScreenTestCaseDefinition() {}

    public ScreenTestCaseDefinition(String testCaseKey, String testName, String screenKey,
                                    TestingLayerCode layerCode, int executionOrder, boolean required,
                                    Set<TestingLayerCode> dependencies, TestCaseSource source,
                                    Supplier<LayerExecutionResult> executor) {
        this.testCaseKey = testCaseKey;
        this.testName = testName;
        this.screenKey = screenKey;
        this.layerCode = layerCode;
        this.executionOrder = executionOrder;
        this.required = required;
        this.dependencies = dependencies;
        this.source = source;
        this.executor = executor;
    }
}
