package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic986EventandwebinarmanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 986;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'event_and_webinar_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'event_and_webinar_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'event_and_webinar_manager-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'event_and_webinar_manager_iconbutton_button_1')]")
	private WebElement eventAndWebinarManagerIconbuttonButton1;

    public Clinic986EventandwebinarmanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic986EventandwebinarmanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic986EventandwebinarmanagerscreenScreen", "/generated/event-and-webinar-manager");
    }
}

