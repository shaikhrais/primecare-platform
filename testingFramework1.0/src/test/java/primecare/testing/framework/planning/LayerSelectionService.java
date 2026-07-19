package primecare.testing.framework.planning;

import primecare.testing.models.TestingLayerCode;

import java.util.LinkedHashSet;
import java.util.Set;

public class LayerSelectionService {

    public static Set<TestingLayerCode> resolveLayers(TestExecutionRequest request) {
        Set<TestingLayerCode> layers = new LinkedHashSet<>();
        
        switch (request.executionMode) {
            case EXACT:
                layers.add(TestingLayerCode.values()[request.level - 1]);
                break;
            case UP_TO:
                for (int i = 0; i < request.level; i++) {
                    layers.add(TestingLayerCode.values()[i]);
                }
                break;
            case RANGE:
                for (int i = request.fromLevel - 1; i < request.toLevel; i++) {
                    layers.add(TestingLayerCode.values()[i]);
                }
                break;
            case SELECTED:
                if (request.selectedLayers != null) {
                    for (TestingLayerCode code : TestingLayerCode.values()) {
                        if (request.selectedLayers.contains(code)) {
                            layers.add(code);
                        }
                    }
                }
                break;
            case ALL_REQUIRED:
            case FULL:
                for (TestingLayerCode code : TestingLayerCode.values()) {
                    layers.add(code);
                }
                break;
        }

        return layers;
    }
}
