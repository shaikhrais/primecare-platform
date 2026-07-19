package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1030DeviceintegrationhubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1030;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'device_integration_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'device_integration_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'device_integration_hub-content')]")
	private WebElement primaryContent;

    public Clinic1030DeviceintegrationhubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1030DeviceintegrationhubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1030DeviceintegrationhubscreenScreen", "/generated/device-integration-hub");
    }
}
