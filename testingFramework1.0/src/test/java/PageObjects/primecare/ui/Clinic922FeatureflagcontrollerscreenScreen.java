package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic922FeatureflagcontrollerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 922;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'feature_flag_controller-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'feature_flag_controller-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'feature_flag_controller-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'feature_flag_controller_iconbutton_button_1')]")
	private WebElement featureFlagControllerIconbuttonButton1;

    public Clinic922FeatureflagcontrollerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic922FeatureflagcontrollerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic922FeatureflagcontrollerscreenScreen", "/generated/feature-flag-controller");
    }
}

