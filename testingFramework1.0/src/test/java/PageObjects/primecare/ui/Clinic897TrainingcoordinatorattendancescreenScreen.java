package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic897TrainingcoordinatorattendancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 897;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_attendance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_attendance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_attendance-content')]")
	private WebElement primaryContent;

    public Clinic897TrainingcoordinatorattendancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic897TrainingcoordinatorattendancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic897TrainingcoordinatorattendancescreenScreen", "/generated/training-coordinator-attendance");
    }
}

