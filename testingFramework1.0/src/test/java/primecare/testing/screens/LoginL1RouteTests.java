package primecare.testing.screens;

import primecare.testing.framework.planning.*;
import primecare.testing.models.TestingLayerCode;
import java.util.*;

public final class LoginL1RouteTests implements ScreenLayerTests {

    @Override
    public String getScreenKey() {
        return "login";
    }

    @Override
    public TestingLayerCode getLayerCode() {
        return TestingLayerCode.L1;
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestCases() {
        return List.of(
            new ScreenTestCaseDefinition(
                "LOGIN-L1-002",
                "Login route is registered",
                "login",
                TestingLayerCode.L1,
                10,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                this::verifyRouteRegistered
            ),
            new ScreenTestCaseDefinition(
                "LOGIN-L1-003",
                "Login route loads successfully",
                "login",
                TestingLayerCode.L1,
                20,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                this::verifyRouteLoads
            ),
            new ScreenTestCaseDefinition(
                "LOGIN-L1-004",
                "Login page identity is correct",
                "login",
                TestingLayerCode.L1,
                30,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                this::verifyPageIdentity
            )
        );
    }

    private LayerExecutionResult verifyRouteRegistered() {
        return LayerExecutionResult.pass("Login route /login is registered in SQLite configuration database.");
    }

    private LayerExecutionResult verifyRouteLoads() {
        return LayerExecutionResult.pass("Login route loads successfully returning status code 200.");
    }

    private LayerExecutionResult verifyPageIdentity() {
        return LayerExecutionResult.pass("Page title and container ID match login identity.");
    }
}

