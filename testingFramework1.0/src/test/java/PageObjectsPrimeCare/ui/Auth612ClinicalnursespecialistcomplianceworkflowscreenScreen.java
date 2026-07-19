package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth612ClinicalnursespecialistcomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 612;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist compliance workflow-title')]")
	private WebElement clinicalnursespecialistcomplianceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist compliance workflow-screen')]")
	private WebElement clinicalnursespecialistcomplianceworkflowScreen;

    public Auth612ClinicalnursespecialistcomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth612ClinicalnursespecialistcomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth612ClinicalnursespecialistcomplianceworkflowscreenScreen", "/rn/cns-workflow");
    }
}
