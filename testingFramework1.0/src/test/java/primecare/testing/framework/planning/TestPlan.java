package primecare.testing.framework.planning;

import java.time.Instant;
import java.util.List;

public final class TestPlan {
    public int planId;
    public String planUuid;
    public TestExecutionRequest request;
    public List<TestPlanItem> items;
    public Instant createdAt;
}
