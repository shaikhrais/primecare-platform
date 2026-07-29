package primecare.testing.framework;

import primecare.testing.models.TestingLayerCode;
import java.util.Set;

public final class TestExecutionRequest {
    public String applicationKey = "primecare-core";
    public String screenKey;
    public Long screenId;
    public String moduleName;
    public Integer level;
    public Integer fromLevel;
    public Integer toLevel;
    public Set<TestingLayerCode> selectedLayers;
    public ExecutionMode executionMode = ExecutionMode.EXACT;
    public boolean includeDependencies = true;
    public boolean stopOnFailure = true;
    public boolean continueOnFailure = false;
    public boolean globalStopOnFailure = false;
    public String roleKey;
    public String environment = "test";
    public Set<String> tags;
    public boolean dryRun = false;
    public ExecutionStrategy executionStrategy = ExecutionStrategy.SCREEN_FIRST;
    public String rerunFailedFromExecution;
    public String rerunBlockedFromExecution;
}

