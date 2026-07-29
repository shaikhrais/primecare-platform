package primecare.testing.framework;

import primecare.testing.models.TestingLayerCode;
import java.util.List;
import java.util.Set;

public interface ScreenTestProvider {
    String getScreenKey();
    Set<TestingLayerCode> getSupportedLayers();
    List<ScreenTestCaseDefinition> getTestsForLayer(TestingLayerCode layerCode);
}

