package primecare.testing.framework.execution;

import org.openqa.selenium.WebDriver;
import utilities.PageRecoveryUtility;
import primecare.testing.models.TestingLayerCode;

public interface LayerTestExecutor {
    TestingLayerCode supports();
    void execute(WebDriver driver, PageRecoveryUtility pageRecovery, int screenId, String screenKey) throws Exception;
}
