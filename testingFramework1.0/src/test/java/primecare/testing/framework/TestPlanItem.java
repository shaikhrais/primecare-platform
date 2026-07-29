package primecare.testing.framework;

import primecare.testing.models.TestingLayerCode;
import java.util.List;
import java.util.Set;

public final class TestPlanItem {
    public int planItemId;
    public int planId;
    public String planItemUuid;
    public int screenId;
    public String screenKey;
    public TestingLayerCode layerCode;
    public int executionOrder;
    public boolean required;
    public boolean applicable;
    public String skipReason;
    public Set<TestingLayerCode> dependencies;
    public TestPlanItemStatus status = TestPlanItemStatus.PLANNED;
    public Integer resultId;
    public List<ScreenTestCaseDefinition> testCases;
}

