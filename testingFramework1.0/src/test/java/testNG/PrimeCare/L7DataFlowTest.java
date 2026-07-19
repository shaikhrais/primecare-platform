package testNG.PrimeCare;

import primecare.testing.base.BaseDatabaseTest;
import primecare.testing.framework.planning.Models.DatabaseValidationRule;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.database.Repositories.DatabaseValidationRepository;
import primecare.testing.validation.TestLayer;
import org.testng.Assert;
import org.testng.annotations.Test;

@TestLayer(TestingLayerCode.L7)
public class L7DataFlowTest extends BaseDatabaseTest {

    @Test(groups = {"l7", "database"})
    public void verifyDatabaseDataFlow() {
        System.out.println("[L7] Validating database persistence and data flow...");
        
        DatabaseValidationRule rule = DatabaseValidationRepository.getRuleByKey("user_session_exists");
        Assert.assertNotNull(rule, "Database validation rule 'user_session_exists' not found in SQLite.");

        // Execute verification SQL from metadata: "SELECT COUNT(*) FROM test_executions WHERE status = 'RUNNING'"
        int count = executeQueryAndGetCount(rule.verificationSql);
        
        // Assert that the active suite execution is indeed recorded
        Assert.assertTrue(count >= 1, "Active execution log is missing from SQLite!");
        System.out.println("[L7] DB Data Flow validation passed. Execution logged: " + count);
    }
}
