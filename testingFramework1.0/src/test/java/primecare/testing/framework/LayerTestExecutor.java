package primecare.testing.framework;

import org.openqa.selenium.WebDriver;
import primecare.testing.models.TestingLayerCode;

public interface LayerTestExecutor {
    TestingLayerCode supports();
    void execute(WebDriver driver, Object unused, int screenId, String screenKey) throws Exception;
}

