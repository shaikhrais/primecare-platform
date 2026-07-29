package primecare.testing.listeners;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import primecare.testing.base.BaseTest;
import primecare.testing.base.BaseUiTest;
import primecare.testing.framework.Models.*;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.Repositories.*;
import primecare.testing.validation.TestLayer;
import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;

import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.time.Instant;
import java.util.UUID;
import java.util.Random;
import java.time.LocalDate;
import java.io.FileInputStream;
import java.util.Properties;

public class TestResultListener implements ITestListener {

    private static final String TEST_RESULT_ATTR = "db_test_result";

    @Override
    public void onTestStart(ITestResult result) {
        if (BaseTest.executionId == -1) return;

        TestResult tr = new TestResult();
        tr.executionId = BaseTest.executionId;
        tr.testClass = result.getTestClass().getName();
        tr.testMethod = result.getMethod().getMethodName();
        tr.status = "RUNNING";
        tr.startedAt = Instant.now().toString();

        // 1. Resolve Layer
        int layerId = resolveLayer(result);
        tr.layerId = layerId;

        if (result.getInstance() instanceof primecare.testing.framework.DynamicScreenTest) {
            primecare.testing.framework.DynamicScreenTest dst = (primecare.testing.framework.DynamicScreenTest) result.getInstance();
            tr.screenId = dst.planItem.screenId;
            tr.testCaseKey = dst.testCase.testCaseKey;
            tr.layerId = dst.planItem.layerCode.ordinal() + 1;
        }

        // 2. Resolve Screen/Endpoint/Workflow from parameters
        Object[] params = result.getParameters();
        if (params != null && params.length > 0) {
            for (Object param : params) {
                if (param instanceof ScreenDefinition) {
                    ScreenDefinition screen = (ScreenDefinition) param;
                    tr.screenId = screen.screenId;
                    tr.testCaseKey = screen.screenKey;
                } else if (param instanceof UiComponentDefinition) {
                    UiComponentDefinition comp = (UiComponentDefinition) param;
                    tr.screenId = comp.screenId;
                    tr.testCaseKey = comp.componentKey;
                } else if (param instanceof ScreenFunctionDefinition) {
                    ScreenFunctionDefinition func = (ScreenFunctionDefinition) param;
                    tr.screenId = func.screenId;
                    tr.testCaseKey = func.functionKey;
                } else if (param instanceof ApiEndpointDefinition) {
                    ApiEndpointDefinition end = (ApiEndpointDefinition) param;
                    tr.endpointId = end.endpointId;
                    tr.testCaseKey = end.endpointKey;
                } else if (param instanceof ApiTestCaseDefinition) {
                    ApiTestCaseDefinition tc = (ApiTestCaseDefinition) param;
                    tr.endpointId = tc.endpointId;
                    tr.testCaseKey = tc.testCaseKey;
                } else if (param instanceof WorkflowDefinition) {
                    WorkflowDefinition wf = (WorkflowDefinition) param;
                    tr.workflowId = wf.workflowId;
                    tr.testCaseKey = wf.workflowKey;
                } else if (param instanceof String) {
                    tr.testCaseKey = (String) param;
                }
            }
        }

        if (tr.testCaseKey == null) {
            tr.testCaseKey = result.getName();
        }

        // Save starting state to SQLite
        TestResultRepository.insertResult(tr);
        result.setAttribute(TEST_RESULT_ATTR, tr);

        if (result.getInstance() instanceof primecare.testing.framework.DynamicScreenTest) {
            primecare.testing.framework.DynamicScreenTest dst = (primecare.testing.framework.DynamicScreenTest) result.getInstance();
            TestPlanItemRepository.updateItemStatus(dst.planItem.planItemId, "RUNNING", tr.resultId);
        }
    }

    @Override
    public void onTestSuccess(ITestResult result) {
        finalizeResult(result, "PASSED", null);
    }

    @Override
    public void onTestFailure(ITestResult result) {
        finalizeResult(result, "FAILED", result.getThrowable());
    }

    @Override
    public void onTestSkipped(ITestResult result) {
        // Check if skipped due to dependency block
        String status = "SKIPPED";
        Throwable t = result.getThrowable();
        if (t != null && t.getMessage() != null && t.getMessage().contains("BLOCKED")) {
            status = "BLOCKED";
        }
        finalizeResult(result, status, t);
    }

    private void finalizeResult(ITestResult result, String status, Throwable throwable) {
        TestResult tr = (TestResult) result.getAttribute(TEST_RESULT_ATTR);
        if (tr == null) return;

        tr.status = status;
        tr.completedAt = Instant.now().toString();
        tr.durationMs = (int) (result.getEndMillis() - result.getStartMillis());

        if (throwable != null) {
            tr.errorType = throwable.getClass().getSimpleName();
            tr.errorMessage = throwable.getMessage();
            StringWriter sw = new StringWriter();
            throwable.printStackTrace(new PrintWriter(sw));
            tr.stackTrace = sw.toString();

            // Extract blocking result ID if blocked by dependency
            if (tr.errorMessage != null && tr.errorMessage.contains("BLOCKING_RESULT_ID:")) {
                try {
                    String[] parts = tr.errorMessage.split("BLOCKING_RESULT_ID:");
                    tr.blockedByResultId = Integer.parseInt(parts[1].trim());
                } catch (Exception e) {
                    System.err.println("[LISTENER] Failed to parse blocking result ID: " + e.getMessage());
                }
            }
        }

        // Save final result to SQLite
        TestResultRepository.updateResult(tr);

        if (result.getInstance() instanceof primecare.testing.framework.DynamicScreenTest) {
            primecare.testing.framework.DynamicScreenTest dst = (primecare.testing.framework.DynamicScreenTest) result.getInstance();
            TestPlanItemRepository.updateItemStatus(dst.planItem.planItemId, status, tr.resultId);
        }

        // Capture screenshot evidence on failure for UI tests
        if ("FAILED".equals(status) && result.getInstance() instanceof BaseUiTest) {
            BaseUiTest uiTest = (BaseUiTest) result.getInstance();
            File screenshotFile = uiTest.captureScreenshot(tr.testMethod + "_" + tr.testCaseKey);
            if (screenshotFile != null) {
                TestEvidence ev = new TestEvidence();
                ev.resultId = tr.resultId;
                ev.evidenceType = "SCREENSHOT";
                ev.evidenceName = screenshotFile.getName();
                ev.filePath = screenshotFile.getAbsolutePath();
                ev.checksum = UUID.randomUUID().toString(); // Placeholder unique hash
                EvidenceRepository.insertEvidence(ev);
                System.out.println("[EVIDENCE] Screenshot captured and recorded at: " + ev.filePath);
            }
            try {
                org.openqa.selenium.logging.LogEntries logEntries = uiTest.getDriver().manage().logs().get(org.openqa.selenium.logging.LogType.BROWSER);
                System.out.println("[BROWSER LOGS ON FAILURE]");
                for (org.openqa.selenium.logging.LogEntry entry : logEntries) {
                    System.out.println("  * [" + entry.getLevel() + "] " + entry.getMessage());
                }
            } catch (Exception e) {
                System.err.println("Could not retrieve browser logs on failure: " + e.getMessage());
            }
        }

        // Auto-create defect for required failed tests
        if ("FAILED".equals(status)) {
            createDefectForFailure(tr);
            registerIssueForFailure(tr, result);
        }

        // Auto-resolve defects and issues on success
        if ("PASSED".equals(status)) {
            DefectRepository.resolveDefects(
                tr.layerId, tr.screenId, tr.endpointId, tr.workflowId, tr.testCaseKey
            );
            if (tr.screenId != null) {
                IssueRepository.resolveIssuesForScreen(
                    String.valueOf(tr.screenId), String.valueOf(tr.executionId)
                );
            }
        }

        // Update verification summary
        updateVerificationSummary(tr);
    }

    private int resolveLayer(ITestResult result) {
        // Try annotation first
        TestLayer anno = result.getMethod().getConstructorOrMethod().getMethod().getAnnotation(TestLayer.class);
        if (anno == null) {
            anno = result.getTestClass().getRealClass().getAnnotation(TestLayer.class);
        }
        if (anno != null) {
            return anno.value().ordinal() + 1;
        }

        // Try package parsing
        String pkg = result.getTestClass().getRealClass().getPackageName();
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

        return 1; // Default
    }

    private void createDefectForFailure(TestResult tr) {
        // Check for duplicates
        boolean exists = DefectRepository.hasOpenDefectFor(
            tr.layerId, tr.screenId, tr.endpointId, tr.workflowId, tr.testCaseKey, tr.errorType
        );

        if (exists) {
            System.out.println("[DEFECT] An open defect already exists for this test case failure. Skipping duplicate creation.");
            return;
        }

        String ref = tr.screenId != null ? "screen_" + tr.screenId : (tr.endpointId != null ? "endpoint_" + tr.endpointId : "workflow_" + tr.workflowId);
        String defectKey = "DEF_" + tr.layerId + "_" + ref + "_" + tr.testCaseKey + "_" + tr.errorType;

        Defect df = new Defect();
        df.defectKey = defectKey;
        df.resultId = tr.resultId;
        df.layerId = tr.layerId;
        df.screenId = tr.screenId;
        df.endpointId = tr.endpointId;
        df.workflowId = tr.workflowId;
        df.severity = "HIGH";
        df.title = "Regression: " + tr.testClass + "." + tr.testMethod + " failed";
        df.description = "Test failed with error: " + tr.errorMessage + "\nTest case key: " + tr.testCaseKey;
        df.reproductionSteps = "Run test class: " + tr.testClass + "\nMethod: " + tr.testMethod;
        df.expectedResult = "Test passed successfully.";
        df.actualResult = tr.errorMessage;
        df.status = "OPEN";
        df.assignedTo = "QA_TEAM";

        DefectRepository.insertDefect(df);
        System.out.println("[DEFECT] Automatically filed defect: " + defectKey);
    }

    private void updateVerificationSummary(TestResult tr) {
        VerificationSummary sum = new VerificationSummary();
        sum.applicationId = 1;
        sum.screenId = tr.screenId;
        sum.endpointId = tr.endpointId;
        sum.workflowId = tr.workflowId;
        sum.layerId = tr.layerId;
        sum.latestResultId = tr.resultId;
        sum.status = tr.status;
        sum.requiredTestCount = 1;
        sum.passedTestCount = "PASSED".equals(tr.status) ? 1 : 0;
        sum.failedTestCount = "FAILED".equals(tr.status) ? 1 : 0;
        sum.blockedTestCount = "BLOCKED".equals(tr.status) ? 1 : 0;
        sum.coveragePercent = "PASSED".equals(tr.status) ? 100.0 : 0.0;
        sum.lastVerifiedAt = Instant.now().toString();

        VerificationRepository.insertOrUpdateSummary(sum);
    }

    @Override
    public void onStart(ITestContext context) {}

    @Override
    public void onFinish(ITestContext context) {}

    private void registerIssueForFailure(TestResult tr, ITestResult result) {
        try {
            // 1. Resolve error details and determine category and severity
            String category = "FUNCTIONALITY";
            String severity = "MEDIUM";
            String errMsg = tr.errorMessage != null ? tr.errorMessage : "Unknown error";
            String errorType = tr.errorType != null ? tr.errorType : "AssertionError";
            
            if (errMsg.contains("404") || errMsg.contains("ROUTE_FAILED_404") || errMsg.contains("not found")) {
                category = "ROUTING";
                severity = "HIGH";
            } else if (errMsg.contains("503") || errMsg.contains("ENVIRONMENT_FAILED_503") || errMsg.contains("service unavailable")) {
                category = "NETWORK";
                severity = "CRITICAL";
            } else if (errMsg.contains("MECHANICAL FIX") || errMsg.contains("CRITICAL_RESOURCE_FAILURE") || errMsg.contains("App crashed")) {
                category = "FLUTTER_RENDERING";
                severity = "CRITICAL";
            } else if (errMsg.contains("SSO") || errMsg.contains("login") || errMsg.contains("auth")) {
                category = "AUTHENTICATION";
                severity = "HIGH";
            } else if (errMsg.contains("REDIRECT_LOOP")) {
                category = "ROUTING";
                severity = "HIGH";
            }
            
            // 2. Generate failure signature & failure hash
            String screenIdStr = tr.screenId != null ? String.valueOf(tr.screenId) : "unknown";
            String signature = category + "|" + screenIdStr + "|" + tr.testCaseKey + "|" + errorType;
            String hash = String.format("%08x", signature.hashCode());
            
            // Read deployment properties
            String deploymentId = primecare.testing.framework.DeploymentConfig.getDeploymentId();
            String deploymentUrl = primecare.testing.framework.DeploymentConfig.getDeploymentUrl();
            
            String runIdStr = String.valueOf(tr.executionId);
            
            // 3. Duplicate detection
            Issue issue = IssueRepository.getIssueByHash(hash);
            boolean isNew = (issue == null);
            String issueId;
            
            if (isNew) {
                // Generate issue ID like ISSUE-20260716-123456
                String dateStr = LocalDate.now().toString().replace("-", "");
                int randomNum = new Random().nextInt(1000000);
                issueId = "ISSUE-" + dateStr + "-" + String.format("%06d", randomNum);
                
                issue = new Issue();
                issue.issueId = issueId;
                issue.projectId = "primecare-clinic";
                issue.title = "Failure in " + tr.testMethod + ": " + errMsg;
                if (issue.title.length() > 100) {
                    issue.title = issue.title.substring(0, 97) + "...";
                }
                issue.description = "Test class: " + tr.testClass + "\nMethod: " + tr.testMethod + "\nMessage: " + errMsg;
                issue.category = category;
                issue.severity = severity;
                issue.priority = "CRITICAL".equals(severity) ? 1 : ("HIGH".equals(severity) ? 2 : 3);
                issue.status = "REGISTERED";
                issue.environment = "production";
                issue.deploymentId = deploymentId;
                issue.screenId = screenIdStr;
                issue.route = tr.testCaseKey;
                issue.testId = tr.testClass + "." + tr.testMethod;
                issue.firstTestRunId = runIdStr;
                issue.latestTestRunId = runIdStr;
                issue.suspectedRootCause = "Initial analysis required.";
                issue.affectedModule = tr.testClass;
                issue.expectedResult = "Test passes and screen renders successfully.";
                issue.actualResult = errMsg;
                issue.failureMessage = errMsg;
                issue.failureSignature = signature;
                issue.failureHash = hash;
                issue.assignedAgent = "ANTIGRAVITY";
                issue.createdAt = Instant.now().toString();
                issue.updatedAt = issue.createdAt;
                
                IssueRepository.insertIssue(issue);
                
                // History
                IssueStatusHistory history = new IssueStatusHistory();
                history.historyId = UUID.randomUUID().toString();
                history.issueId = issueId;
                history.previousStatus = null;
                history.newStatus = "REGISTERED";
                history.reason = "Initial failure signature discovery.";
                history.changedBy = "ANTIGRAVITY";
                history.deploymentId = deploymentId;
                history.testRunId = runIdStr;
                history.changedAt = issue.createdAt;
                IssueRepository.insertStatusHistory(history);
                
                System.out.println("[GOVERNANCE] Registered new issue: " + issueId);
            } else {
                issueId = issue.issueId;
                String oldStatus = issue.status;
                
                // Reopen if closed/resolved
                if ("CLOSED".equals(oldStatus) || "VERIFIED_FIXED".equals(oldStatus)) {
                    issue.status = "DISCOVERED"; // Reopened as REGRESSION
                    issue.updatedAt = Instant.now().toString();
                    issue.latestTestRunId = runIdStr;
                    IssueRepository.updateIssue(issue);
                    
                    // Status History for regression
                    IssueStatusHistory history = new IssueStatusHistory();
                    history.historyId = UUID.randomUUID().toString();
                    history.issueId = issueId;
                    history.previousStatus = oldStatus;
                    history.newStatus = "DISCOVERED";
                    history.reason = "Regression detected. Issue occurred again in test run: " + runIdStr;
                    history.changedBy = "ANTIGRAVITY";
                    history.deploymentId = deploymentId;
                    history.testRunId = runIdStr;
                    history.changedAt = issue.updatedAt;
                    IssueRepository.insertStatusHistory(history);
                    
                    System.out.println("[GOVERNANCE] Reopened issue as regression: " + issueId);
                } else {
                    issue.latestTestRunId = runIdStr;
                    issue.updatedAt = Instant.now().toString();
                    IssueRepository.updateIssue(issue);
                }
            }
            
            // 4. Record occurrence
            IssueOccurrence occ = new IssueOccurrence();
            occ.occurrenceId = UUID.randomUUID().toString();
            occ.issueId = issueId;
            occ.testRunId = runIdStr;
            occ.deploymentId = deploymentId;
            occ.screenId = screenIdStr;
            occ.route = tr.testCaseKey;
            occ.occurredAt = Instant.now().toString();
            
            // If it's a UI test, retrieve driver context details
            if (result.getInstance() instanceof BaseUiTest) {
                BaseUiTest uiTest = (BaseUiTest) result.getInstance();
                try {
                    occ.currentUrl = uiTest.getDriver().getCurrentUrl();
                    occ.pageTitle = uiTest.getDriver().getTitle();
                } catch (Exception e) {}
            }
            
            IssueRepository.insertOccurrence(occ);
            
            // 5. Log activity
            ActivityLog log = new ActivityLog();
            log.activityId = UUID.randomUUID().toString();
            log.runId = runIdStr;
            log.issueId = issueId;
            log.deploymentId = deploymentId;
            log.activityType = isNew ? "issue_registered" : "issue_occurrence_recorded";
            log.description = isNew ? "Registered new issue: " + issueId : "Recorded occurrence for issue: " + issueId;
            log.createdBy = "ANTIGRAVITY";
            log.createdAt = occ.occurredAt;
            IssueRepository.insertActivityLog(log);
            
        } catch (Exception e) {
            System.err.println("[GOVERNANCE] Error in registerIssueForFailure: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

