package primecare.testing.framework;

import primecare.testing.models.TestingLayerCode;

import java.util.LinkedHashSet;
import java.util.Set;

public class DependencyExpansionService {

    public static Set<TestingLayerCode> expandDependencies(Set<TestingLayerCode> targetLayers, boolean includeDependencies) {
        if (!includeDependencies) {
            return targetLayers;
        }

        Set<TestingLayerCode> expanded = new LinkedHashSet<>();
        int maxOrder = 0;
        for (TestingLayerCode code : targetLayers) {
            int order = code.ordinal() + 1;
            if (order > maxOrder) {
                maxOrder = order;
            }
        }

        for (int i = 0; i < maxOrder; i++) {
            expanded.add(TestingLayerCode.values()[i]);
        }

        return expanded;
    }
}

