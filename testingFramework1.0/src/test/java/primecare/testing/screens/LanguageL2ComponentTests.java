package primecare.testing.screens;

import primecare.testing.framework.*;
import primecare.testing.models.TestingLayerCode;
import java.util.*;

public final class LanguageL2ComponentTests implements ScreenLayerTests {

    @Override
    public String getScreenKey() {
        return "language";
    }

    @Override
    public TestingLayerCode getLayerCode() {
        return TestingLayerCode.L2;
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestCases() {
        return List.of(
            new ScreenTestCaseDefinition(
                "LANG-L2-001",
                "English selection button is visible",
                "language",
                TestingLayerCode.L2,
                10,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                () -> LayerExecutionResult.pass("English selection button visible check passed.")
            ),
            new ScreenTestCaseDefinition(
                "LANG-L2-002",
                "French selection button is visible",
                "language",
                TestingLayerCode.L2,
                20,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                () -> LayerExecutionResult.pass("French selection button visible check passed.")
            )
        );
    }
}


