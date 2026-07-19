package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic915CompliancetrainingtrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 915;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training_tracker-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training_tracker_iconbutton_button_1')]")
	private WebElement complianceTrainingTrackerIconbuttonButton1;

    public Clinic915CompliancetrainingtrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic915CompliancetrainingtrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic915CompliancetrainingtrackerscreenScreen", "/generated/compliance-training-tracker");
    }
}
