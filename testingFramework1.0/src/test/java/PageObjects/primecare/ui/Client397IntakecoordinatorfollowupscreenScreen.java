package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client397IntakecoordinatorfollowupscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 397;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_follow_up-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_follow_up-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_follow_up-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorfollowup-content')]")
	private WebElement intakecoordinatorfollowupContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorfollowup-btn-3')]")
	private WebElement intakecoordinatorfollowupBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorfollowup-btn-2')]")
	private WebElement intakecoordinatorfollowupBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorfollowup-btn-1')]")
	private WebElement intakecoordinatorfollowupBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorfollowup-title')]")
	private WebElement intakecoordinatorfollowupTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorfollowup-screen')]")
	private WebElement intakecoordinatorfollowupScreen;

    public Client397IntakecoordinatorfollowupscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client397IntakecoordinatorfollowupscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client397IntakecoordinatorfollowupscreenScreen", "/executive/intake-coordinator-follow-up");
    }
}

