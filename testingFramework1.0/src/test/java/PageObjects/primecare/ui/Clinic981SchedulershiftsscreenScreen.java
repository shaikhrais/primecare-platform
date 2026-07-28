package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic981SchedulershiftsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 981;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_shifts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_shifts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_shifts-content')]")
	private WebElement primaryContent;

    public Clinic981SchedulershiftsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic981SchedulershiftsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic981SchedulershiftsscreenScreen", "/generated/scheduler-shifts");
    }
}

