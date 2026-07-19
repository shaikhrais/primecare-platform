package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic357VitalsentryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 357;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_vitals_log-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_vitals_log-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_vitals_log-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-screen')]")
	private WebElement pswvitalslogScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-btn-3')]")
	private WebElement pswvitalslogBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-btn-2')]")
	private WebElement pswvitalslogBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-content')]")
	private WebElement pswvitalslogContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-title')]")
	private WebElement pswvitalslogTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-loading')]")
	private WebElement pswvitalslogLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvitalslog-btn-1')]")
	private WebElement pswvitalslogBtn1;

    public Clinic357VitalsentryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic357VitalsentryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic357VitalsentryscreenScreen", "/offices/clinical/roles/psw/observation-vitals-log");
    }
}
