package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic381RpnvitalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 381;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_vitals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_vitals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_vitals-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-btn-1')]")
	private WebElement rpnvitalsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-btn-3')]")
	private WebElement rpnvitalsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-screen')]")
	private WebElement rpnvitalsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-content')]")
	private WebElement rpnvitalsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-loading')]")
	private WebElement rpnvitalsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-title')]")
	private WebElement rpnvitalsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnvitals-btn-2')]")
	private WebElement rpnvitalsBtn2;

    public Clinic381RpnvitalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic381RpnvitalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic381RpnvitalsscreenScreen", "/offices/clinical/roles/rpn/vitals");
    }
}

