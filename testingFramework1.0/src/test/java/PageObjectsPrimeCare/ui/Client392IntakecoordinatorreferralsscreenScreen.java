package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client392IntakecoordinatorreferralsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 392;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_referrals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_referrals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_referrals-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorreferrals-title')]")
	private WebElement intakecoordinatorreferralsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorreferrals-btn-1')]")
	private WebElement intakecoordinatorreferralsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorreferrals-screen')]")
	private WebElement intakecoordinatorreferralsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorreferrals-content')]")
	private WebElement intakecoordinatorreferralsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorreferrals-btn-3')]")
	private WebElement intakecoordinatorreferralsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorreferrals-btn-2')]")
	private WebElement intakecoordinatorreferralsBtn2;

    public Client392IntakecoordinatorreferralsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client392IntakecoordinatorreferralsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client392IntakecoordinatorreferralsscreenScreen", "/executive/intake-coordinator-referrals");
    }
}
