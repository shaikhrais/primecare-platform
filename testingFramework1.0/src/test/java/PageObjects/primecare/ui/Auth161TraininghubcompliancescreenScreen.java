package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth161TraininghubcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 161;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubcompliance-btn-1')]")
	private WebElement traininghubcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubcompliance-title')]")
	private WebElement traininghubcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubcompliance-screen')]")
	private WebElement traininghubcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubcompliance-btn-2')]")
	private WebElement traininghubcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubcompliance-btn-3')]")
	private WebElement traininghubcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubcompliance-content')]")
	private WebElement traininghubcomplianceContent;

    public Auth161TraininghubcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth161TraininghubcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth161TraininghubcompliancescreenScreen", "/common/training-hub-compliance");
    }
}

