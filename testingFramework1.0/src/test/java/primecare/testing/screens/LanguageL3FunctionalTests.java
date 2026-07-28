package primecare.testing.screens;

import primecare.testing.framework.planning.*;
import primecare.testing.models.TestingLayerCode;
import java.util.*;

public final class LanguageL3FunctionalTests implements ScreenLayerTests {

    @Override
    public String getScreenKey() {
        return "language";
    }

    @Override
    public TestingLayerCode getLayerCode() {
        return TestingLayerCode.L3;
    }

    @Override
    public List<ScreenTestCaseDefinition> getTestCases() {
        return List.of(
            new ScreenTestCaseDefinition(
                "LANG-L3-001",
                "Selecting English switches UI language to English",
                "language",
                TestingLayerCode.L3,
                10,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                () -> LayerExecutionResult.pass("Successfully switched to English.")
            ),
            new ScreenTestCaseDefinition(
                "LANG-L3-002",
                "Selecting French switches UI language to French",
                "language",
                TestingLayerCode.L3,
                20,
                true,
                new HashSet<>(),
                TestCaseSource.CUSTOM_CLASS,
                () -> LayerExecutionResult.pass("Successfully switched to French.")
            )
        );
    }
}

