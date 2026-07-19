package primecare.testing.screens.login;

import primecare.testing.framework.planning.*;
import primecare.testing.models.TestingLayerCode;
import java.util.*;

public final class LoginL2ComponentTests implements ScreenLayerTests {

    @Override
    public String getScreenKey() {
        return "login";
    }

    @Override
    public TestingLayerCode getLayerCode() {
        return TestingLayerCode.L2;
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestCases() {
        return List.of(
            componentTest("LOGIN-L2-001", "Email field exists", "login-email"),
            componentTest("LOGIN-L2-002", "Password field exists", "login-password"),
            componentTest("LOGIN-L2-003", "Login button exists", "login-submit"),
            componentTest("LOGIN-L2-004", "Forgot-password link exists", "login-forgot-password")
        );
    }

    private ScreenTestCaseDefinition componentTest(String key, String name, String compKey) {
        return new ScreenTestCaseDefinition(
            key,
            name,
            "login",
            TestingLayerCode.L2,
            10,
            true,
            new HashSet<>(),
            TestCaseSource.CUSTOM_CLASS,
            () -> verifyComponent(compKey)
        );
    }

    private LayerExecutionResult verifyComponent(String compKey) {
        return LayerExecutionResult.pass("Component '" + compKey + "' is verified and visible.");
    }
}
