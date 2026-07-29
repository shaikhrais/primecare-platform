package primecare.testing.framework;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class DuplicateTestCaseValidator {

    public static void validateUniqueKeys(List<ScreenTestCaseDefinition> testCases) {
        Set<String> keys = new HashSet<>();
        for (ScreenTestCaseDefinition tc : testCases) {
            if (keys.contains(tc.testCaseKey)) {
                throw new IllegalStateException("DuplicateTestCaseException: Found duplicate test case key '" + tc.testCaseKey + "' during planning.");
            }
            keys.add(tc.testCaseKey);
        }
    }
}

