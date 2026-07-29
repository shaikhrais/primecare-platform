package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic562FollowupscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 562;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-btn-3')]")
	private WebElement followupBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-btn-1')]")
	private WebElement followupBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-loading')]")
	private WebElement followupLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'followup-btn-2')]")
	private WebElement followupBtn2;

    public Clinic562FollowupscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic562FollowupscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic562FollowupscreenScreen", "/offices/clinical/roles/intake_coordinator/followup");
    }
}

