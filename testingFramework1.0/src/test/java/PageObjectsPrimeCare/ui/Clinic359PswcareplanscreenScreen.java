package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic359PswcareplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 359;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_care_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_care_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_care_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-screen')]")
	private WebElement pswcareplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-btn-1')]")
	private WebElement pswcareplanBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-title')]")
	private WebElement pswcareplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-btn-2')]")
	private WebElement pswcareplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-content')]")
	private WebElement pswcareplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-btn-3')]")
	private WebElement pswcareplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcareplan-loading')]")
	private WebElement pswcareplanLoading;

    public Clinic359PswcareplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic359PswcareplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic359PswcareplanscreenScreen", "/offices/clinical/roles/psw/care-plan");
    }
}
