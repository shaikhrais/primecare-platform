package pageobjects.primecare.ui;

import base.baseTest;

/** Registered navigation mapping only; this is not browser completion evidence. */
public class MaintenanceConfigurationScreen extends baseTest {
    public static final int SCREEN_ID = 1264;

    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "MaintenanceConfigurationScreen", "/maintenance/configuration");
    }
}
