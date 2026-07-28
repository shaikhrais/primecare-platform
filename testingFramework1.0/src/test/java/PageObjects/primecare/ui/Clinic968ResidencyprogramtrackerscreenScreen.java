package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic968ResidencyprogramtrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 968;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'residency_program_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'residency_program_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'residency_program_tracker-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'residency_program_tracker_iconbutton_button_1')]")
	private WebElement residencyProgramTrackerIconbuttonButton1;

    public Clinic968ResidencyprogramtrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic968ResidencyprogramtrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic968ResidencyprogramtrackerscreenScreen", "/generated/residency-program-tracker");
    }
}

