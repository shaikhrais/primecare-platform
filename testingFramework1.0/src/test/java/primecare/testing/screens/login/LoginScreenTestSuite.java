package primecare.testing.screens.login;

import primecare.testing.framework.planning.*;
import primecare.testing.models.TestingLayerCode;

import java.util.Collections;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;

@PrimeCareScreenTestSuite(
    screenKey = "login",
    module = "authentication"
)
public final class LoginScreenTestSuite implements ScreenTestProvider {

    private final LoginL1RouteTests l1Tests = new LoginL1RouteTests();
    private final LoginL2ComponentTests l2Tests = new LoginL2ComponentTests();
    private final LoginL3FunctionalTests l3Tests = new LoginL3FunctionalTests();

    @Override
    public String getScreenKey() {
        return "login";
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
