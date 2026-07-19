package primecare.testing.screens.language;

import primecare.testing.framework.planning.*;
import primecare.testing.models.TestingLayerCode;

import java.util.Collections;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;

@PrimeCareScreenTestSuite(
    screenKey = "language",
    module = "authentication"
)
public final class LanguageScreenTestSuite implements ScreenTestProvider {

    private final LanguageL1RouteTests l1Tests = new LanguageL1RouteTests();
    private final LanguageL2ComponentTests l2Tests = new LanguageL2ComponentTests();
    private final LanguageL3FunctionalTests l3Tests = new LanguageL3FunctionalTests();

    @Override
    public String getScreenKey() {
        return "language";
    }

    @Override
    public Set<TestingLayerCode> getSupportedLayers() {
        return EnumSet.of(
            TestingLayerCode.L1,
            TestingLayerCode.L2,
            TestingLayerCode.L3
        );
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestsForLayer(TestingLayerCode layerCode) {
        return switch (layerCode) {
            case L1 -> l1Tests.getTestCases();
            case L2 -> l2Tests.getTestCases();
            case L3 -> l3Tests.getTestCases();
            default -> Collections.emptyList();
        };
    }
}
