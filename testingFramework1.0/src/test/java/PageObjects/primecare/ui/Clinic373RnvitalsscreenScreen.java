package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic373RnvitalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 373;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_vitals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_vitals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_vitals-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-title')]")
	private WebElement rnvitalsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-loading')]")
	private WebElement rnvitalsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-screen')]")
	private WebElement rnvitalsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-btn-2')]")
	private WebElement rnvitalsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-btn-3')]")
	private WebElement rnvitalsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-content')]")
	private WebElement rnvitalsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnvitals-btn-1')]")
	private WebElement rnvitalsBtn1;

    public Clinic373RnvitalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic373RnvitalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic373RnvitalsscreenScreen", "/offices/clinical/roles/rn/vitals");
    }
}

