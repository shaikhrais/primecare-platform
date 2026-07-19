package primecare.testing.framework.planning;

import primecare.testing.framework.database.SQLiteConnectionManager;
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.framework.database.Repositories.ScreenTestCaseRepository;
import primecare.testing.framework.planning.Models.ScreenDefinition;
import primecare.testing.models.TestingLayerCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ScreenTestMetadataSynchronizer {

    public static void synchronizeMetadata() {
        System.out.println("[SYNC] Starting screen-wise test metadata synchronization...");
        for (ScreenTestProvider provider : ScreenTestRegistry.findAll()) {
            String screenKey = provider.getScreenKey();
            ScreenDefinition screen = ScreenRepository.getScreenByKey(screenKey);
            if (screen == null) {
                throw new IllegalArgumentException("MetadataSyncException: Unknown screen key '" + screenKey + "' declared in suite " + provider.getClass().getName());
            }

            // Mark existing tests for this screen inactive to handle removals
            ScreenTestCaseRepository.markAllTestCasesInactive(screen.screenId);

            // Synchronize each layer's tests
            for (TestingLayerCode layerCode : provider.getSupportedLayers()) {
                java.util.List<ScreenTestCaseDefinition> testCases = provider.getTestsForLayer(layerCode);
                if (testCases != null) {
                    for (ScreenTestCaseDefinition tc : testCases) {
                        tc.screenKey = screenKey;
                        tc.layerCode = layerCode;
                        tc.source = TestCaseSource.CUSTOM_CLASS;
                        tc.testClass = provider.getClass().getName();
                        tc.testMethod = "execute"; // Or custom method reference

                        ScreenTestCaseRepository.insertOrUpdateTestCase(tc);
                    }
                }
            }
        }
        System.out.println("[SYNC] Metadata synchronization complete.");
    }
}
