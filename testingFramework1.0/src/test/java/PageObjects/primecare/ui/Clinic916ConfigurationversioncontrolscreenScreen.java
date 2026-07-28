package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic916ConfigurationversioncontrolscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 916;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'configuration_version_control-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'configuration_version_control-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'configuration_version_control-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'configuration_version_control_elevatedbutton_button_1')]")
	private WebElement configurationVersionControlElevatedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'configuration_version_control_outlinedbutton_button_1')]")
	private WebElement configurationVersionControlOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'configuration_version_control_iconbutton_button_1')]")
	private WebElement configurationVersionControlIconbuttonButton1;

    public Clinic916ConfigurationversioncontrolscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic916ConfigurationversioncontrolscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic916ConfigurationversioncontrolscreenScreen", "/generated/configuration-version-control");
    }
}

