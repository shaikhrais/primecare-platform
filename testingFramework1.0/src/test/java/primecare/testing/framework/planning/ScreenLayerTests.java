package primecare.testing.framework.planning;

import primecare.testing.models.TestingLayerCode;
import java.util.List;

public interface ScreenLayerTests {
    String getScreenKey();
    TestingLayerCode getLayerCode();
    List<ScreenTestCaseDefinition> getTestCases();
}
