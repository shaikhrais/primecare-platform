package primecare.testing.framework;

import java.time.Instant;

public class Models {

    // 1. ApplicationDefinition
    public static class ApplicationDefinition {
        public int applicationId;
        public String applicationKey;
        public String applicationName;
        public String baseUrl;
        public String apiBaseUrl;
        public String environment;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 2. ScreenDefinition
    public static class ScreenDefinition {
        public int screenId;
        public int applicationId;
        public String screenKey;
        public String screenName;
        public String route;
        public String pageClass;
        public String moduleName;
        public String requiredRole;
        public String implementationStatus; // e.g. UNKNOWN, VERIFIED
        public String verificationStatus;   // e.g. NOT_TESTED
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 3. TestingLayer
    public static class TestingLayer {
        public int layerId;
        public String layerCode;
        public String layerName;
        public int layerOrder;
        public String description;
        public boolean blocking;
        public boolean active;
    }

    // 4. ScreenLayerRequirement
    public static class ScreenLayerRequirement {
        public int requirementId;
        public int screenId;
        public int layerId;
        public boolean required;
        public Integer dependencyLayerId;
        public String configurationJson;
        public String createdAt;
        public String updatedAt;
    }

    // 5. UiComponentDefinition
    public static class UiComponentDefinition {
        public int componentId;
        public int screenId;
        public String componentKey;
        public String componentName;
        public String componentType;
        public String locatorStrategy;
        public String locatorValue;
        public String dataCy;
        public boolean required;
        public boolean visibleRequired;
        public boolean enabledRequired;
        public String expectedText;
        public String parentComponentKey;
        public String metadataJson;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 6. ScreenFunctionDefinition
    public static class ScreenFunctionDefinition {
        public int functionId;
        public int screenId;
        public String functionKey;
        public String functionName;
        public String triggerComponentKey;
        public String functionType;
        public String expectedResult;
        public String validationRule;
        public String businessRuleKey;
        public String apiEndpointKey;
        public String databaseValidationKey;
        public boolean required;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 7. BusinessRuleDefinition
    public static class BusinessRuleDefinition {
        public int businessRuleId;
        public String ruleKey;
        public String ruleName;
        public String moduleName;
        public String description;
        public String inputDefinitionJson;
        public String expectedLogicJson;
        public String validationExpression;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 8. ApiEndpointDefinition
    public static class ApiEndpointDefinition {
        public int endpointId;
        public int applicationId;
        public String endpointKey;
        public String endpointName;
        public String httpMethod;
        public String path;
        public String authenticationType;
        public String requestSchemaPath;
        public String responseSchemaPath;
        public String expectedStatusCodes;
        public String requiredRole;
        public String operationType;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 9. ApiTestCaseDefinition
    public static class ApiTestCaseDefinition {
        public int apiTestCaseId;
        public int endpointId;
        public String testCaseKey;
        public String testCaseName;
        public String testType;
        public String requestHeadersJson;
        public String requestPathParamsJson;
        public String requestQueryParamsJson;
        public String requestBodyJson;
        public Integer expectedStatusCode;
        public String expectedResponseJson;
        public String expectedSchemaPath;
        public String expectedErrorCode;
        public boolean required;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 10. IntegrationMapping
    public static class IntegrationMapping {
        public int integrationId;
        public int screenId;
        public Integer functionId;
        public Integer componentId;
        public Integer endpointId;
        public String requestMappingJson;
        public String responseMappingJson;
        public String expectedUiChangeJson;
        public String expectedDatabaseChangeJson;
        public boolean required;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 11. DatabaseValidationRule
    public static class DatabaseValidationRule {
        public int databaseValidationId;
        public String validationKey;
        public String validationName;
        public String databaseName;
        public String tableName;
        public String validationType;
        public String setupSql;
        public String verificationSql;
        public String cleanupSql;
        public String expectedResultJson;
        public String parametersJson;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 12. RoleDefinition
    public static class RoleDefinition {
        public int roleId;
        public String roleKey;
        public String roleName;
        public String description;
        public String testEmail;
        public String testPassword;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 13. PermissionDefinition
    public static class PermissionDefinition {
        public int permissionId;
        public String permissionKey;
        public String permissionName;
        public String resourceType;
        public String resourceKey;
        public String actionName;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 14. WorkflowDefinition
    public static class WorkflowDefinition {
        public int workflowId;
        public String workflowKey;
        public String workflowName;
        public String moduleName;
        public String description;
        public String requiredRole;
        public boolean active;
        public String createdAt;
        public String updatedAt;
    }

    // 15. WorkflowStepDefinition
    public static class WorkflowStepDefinition {
        public int workflowStepId;
        public int workflowId;
        public int stepOrder;
        public String stepKey;
        public String screenKey;
        public String functionKey;
        public String endpointKey;
        public String actionType;
        public String actionConfigurationJson;
        public String expectedResultJson;
        public boolean continueOnFailure;
        public String createdAt;
        public String updatedAt;
    }

    // 16. TestExecution
    public static class TestExecution {
        public int executionId;
        public String executionUuid;
        public String suiteName;
        public String environment;
        public Integer applicationId;
        public String startedAt;
        public String completedAt;
        public String status;
        public String triggeredBy;
        public String gitBranch;
        public String gitCommit;
        public String javaVersion;
        public String browserName;
        public String browserVersion;
        public String operatingSystem;
        public int totalTests;
        public int passedTests;
        public int failedTests;
        public int skippedTests;
    }

    // 17. TestResult
    public static class TestResult {
        public int resultId;
        public int executionId;
        public int layerId;
        public Integer screenId;
        public Integer endpointId;
        public Integer workflowId;
        public String testClass;
        public String testMethod;
        public String testCaseKey;
        public String status;
        public String startedAt;
        public String completedAt;
        public int durationMs;
        public String expectedResult;
        public String actualResult;
        public String errorType;
        public String errorMessage;
        public String stackTrace;
        public int retryCount;
        public Integer blockedByResultId;
        public String createdAt;
    }

    // 18. TestEvidence
    public static class TestEvidence {
        public int evidenceId;
        public int resultId;
        public String evidenceType;
        public String evidenceName;
        public String filePath;
        public String contentText;
        public String contentJson;
        public String checksum;
        public String createdAt;
    }

    // 19. Defect
    public static class Defect {
        public int defectId;
        public String defectKey;
        public Integer resultId;
        public int layerId;
        public Integer screenId;
        public Integer endpointId;
        public Integer workflowId;
        public String severity;
        public String title;
        public String description;
        public String reproductionSteps;
        public String expectedResult;
        public String actualResult;
        public String status; // OPEN, RESOLVED
        public String assignedTo;
        public String createdAt;
        public String updatedAt;
        public String resolvedAt;
    }

    // 20. VerificationSummary
    public static class VerificationSummary {
        public int verificationId;
        public int applicationId;
        public Integer screenId;
        public Integer endpointId;
        public Integer workflowId;
        public int layerId;
        public Integer latestResultId;
        public String status;
        public int requiredTestCount;
        public int passedTestCount;
        public int failedTestCount;
        public int blockedTestCount;
        public double coveragePercent;
        public String lastVerifiedAt;
        public String updatedAt;
    }

    // 21. CertificationRecord
    public static class CertificationRecord {
        public int certificationId;
        public int applicationId;
        public Integer screenId;
        public Integer endpointId;
        public Integer workflowId;
        public String certificationStatus;
        public Integer certifiedExecutionId;
        public String certifiedAt;
        public String certificationNotes;
        public String layerSummaryJson;
        public int openDefectCount;
        public boolean evidenceComplete;
    }

    // 22. Issue
    public static class Issue {
        public String issueId;
        public String projectId;
        public String title;
        public String description;
        public String category;
        public String severity;
        public Integer priority;
        public String status;
        public String environment;
        public String deploymentId;
        public String screenId;
        public String route;
        public String componentId;
        public String testId;
        public String firstTestRunId;
        public String latestTestRunId;
        public String suspectedRootCause;
        public String confirmedRootCause;
        public String affectedModule;
        public String reproductionSteps;
        public String expectedResult;
        public String actualResult;
        public String failureMessage;
        public String failureSignature;
        public String failureHash;
        public String assignedAgent;
        public String createdAt;
        public String updatedAt;
        public String resolvedAt;
        public String closedAt;
    }

    // 23. IssueOccurrence
    public static class IssueOccurrence {
        public String occurrenceId;
        public String issueId;
        public String testRunId;
        public String deploymentId;
        public String screenId;
        public String route;
        public String currentUrl;
        public String pageTitle;
        public String screenIdentifier;
        public Integer httpStatus;
        public String screenshotId;
        public Integer consoleErrorCount;
        public Integer networkErrorCount;
        public String occurredAt;
    }

    // 24. IssueStatusHistory
    public static class IssueStatusHistory {
        public String historyId;
        public String issueId;
        public String previousStatus;
        public String newStatus;
        public String reason;
        public String changedBy;
        public String deploymentId;
        public String testRunId;
        public String changedAt;
    }

    // 25. FixAttempt
    public static class FixAttempt {
        public String fixAttemptId;
        public String issueId;
        public int attemptNumber;
        public String description;
        public String suspectedFix;
        public String filesChanged;
        public String codeChangeSummary;
        public String commitId;
        public String buildId;
        public String deploymentId;
        public String retestRunId;
        public String result;
        public String failureReason;
        public String startedAt;
        public String completedAt;
    }

    // 26. CodeChange
    public static class CodeChange {
        public String changeId;
        public String fixAttemptId;
        public String issueId;
        public String filePath;
        public String changeType;
        public String beforeSummary;
        public String afterSummary;
        public String reason;
        public String commitId;
        public String createdAt;
    }

    // 27. IssueLink
    public static class IssueLink {
        public String linkId;
        public String issueId;
        public String linkedEntityType;
        public String linkedEntityId;
        public String relationshipType;
        public String createdAt;
    }

    // 28. ActivityLog
    public static class ActivityLog {
        public String activityId;
        public String runId;
        public String issueId;
        public String fixAttemptId;
        public String deploymentId;
        public String activityType;
        public String description;
        public String metadataJson;
        public String createdBy;
        public String createdAt;
    }
}

