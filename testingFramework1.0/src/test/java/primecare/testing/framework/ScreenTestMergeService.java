package primecare.testing.framework;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ScreenTestMergeService {

    public static List<ScreenTestCaseDefinition> mergeTests(List<ScreenTestCaseDefinition> discoveredTests) {
        // Enforce duplicate key validation first
        DuplicateTestCaseValidator.validateUniqueKeys(discoveredTests);

        // Sort them by execution order
        List<ScreenTestCaseDefinition> merged = new ArrayList<>(discoveredTests);
        Collections.sort(merged, Comparator.comparingInt(a -> a.executionOrder));

        return merged;
    }
}

