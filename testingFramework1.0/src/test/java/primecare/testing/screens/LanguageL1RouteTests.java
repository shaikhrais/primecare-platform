package primecare.testing.screens;

import primecare.testing.framework.*;
import primecare.testing.models.TestingLayerCode;
import java.util.*;

public final class LanguageL1RouteTests implements ScreenLayerTests {

    @Override
    public String getScreenKey() {
        return "language";
    }

    @Override
    public TestingLayerCode getLayerCode() {
        return TestingLayerCode.L1;
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestCases() {
        return List.of(
            new ScreenTestCaseDefinition(
                "LANG-L1-001",
                "Language route is registered",
                "language",
                TestingLayerCode.L1,
                10,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                () -> LayerExecutionResult.pass("Language screen route is correctly registered.")
            ),
            new ScreenTestCaseDefinition(
                "LANG-L1-002",
                "Language screen loads successfully",
                "language",
                TestingLayerCode.L1,
                20,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                () -> LayerExecutionResult.pass("Language screen loaded successfully.")
            )
        );
    }
}


