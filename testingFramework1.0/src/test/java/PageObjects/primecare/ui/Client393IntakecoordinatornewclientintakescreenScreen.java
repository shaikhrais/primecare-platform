package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client393IntakecoordinatornewclientintakescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 393;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_new_client_intake-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_new_client_intake-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_new_client_intake-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatornewclientintake-btn-1')]")
	private WebElement intakecoordinatornewclientintakeBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatornewclientintake-btn-2')]")
	private WebElement intakecoordinatornewclientintakeBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatornewclientintake-screen')]")
	private WebElement intakecoordinatornewclientintakeScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatornewclientintake-title')]")
	private WebElement intakecoordinatornewclientintakeTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatornewclientintake-content')]")
	private WebElement intakecoordinatornewclientintakeContent;

    public Client393IntakecoordinatornewclientintakescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client393IntakecoordinatornewclientintakescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client393IntakecoordinatornewclientintakescreenScreen", "/executive/intake-coordinator-new-client-intake");
    }
}

