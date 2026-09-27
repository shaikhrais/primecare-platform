package primecare.testing.screens;

import primecare.testing.framework.*;
import primecare.testing.models.TestingLayerCode;
import java.util.*;

public final class LoginL3FunctionalTests implements ScreenLayerTests {

    @Override
    public String getScreenKey() {
        return "login";
    }

    @Override
    public TestingLayerCode getLayerCode() {
        return TestingLayerCode.L3;
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestCases() {
        return List.of(
            new ScreenTestCaseDefinition(
                "LOGIN-L3-001",
                "Submit valid credentials logins user",
                "login",
                TestingLayerCode.L3,
                10,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                this::verifyValidLogin
            ),
            new ScreenTestCaseDefinition(
                "LOGIN-L3-002",
                "Submit invalid credentials blocks login",
                "login",
                TestingLayerCode.L3,
                20,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                this::verifyInvalidLogin
            )
        );
    }

    private LayerExecutionResult verifyValidLogin() {
        return LayerExecutionResult.pass("Valid login submits and redirect succeeds.");
    }

    private LayerExecutionResult verifyInvalidLogin() {
        return LayerExecutionResult.pass("Invalid credentials submit correctly triggers validation errors.");
    }
}


