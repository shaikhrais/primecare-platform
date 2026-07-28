package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client395IntakecoordinatorbookingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 395;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_booking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_booking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_booking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorbooking-btn-3')]")
	private WebElement intakecoordinatorbookingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorbooking-btn-2')]")
	private WebElement intakecoordinatorbookingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorbooking-btn-1')]")
	private WebElement intakecoordinatorbookingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorbooking-content')]")
	private WebElement intakecoordinatorbookingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorbooking-screen')]")
	private WebElement intakecoordinatorbookingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorbooking-title')]")
	private WebElement intakecoordinatorbookingTitle;

    public Client395IntakecoordinatorbookingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client395IntakecoordinatorbookingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client395IntakecoordinatorbookingscreenScreen", "/executive/intake-coordinator-booking");
    }
}

