package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic701PswschedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 701;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_schedule-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswschedulescreen-screen')]")
	private WebElement pswschedulescreenScreen;

    public Clinic701PswschedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic701PswschedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic701PswschedulescreenScreen", "/generated/psw-schedule");
    }
}

