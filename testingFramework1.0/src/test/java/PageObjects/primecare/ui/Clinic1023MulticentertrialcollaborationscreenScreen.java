package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1023MulticentertrialcollaborationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1023;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'multi_center_trial_collaboration-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'multi_center_trial_collaboration-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'multi_center_trial_collaboration-content')]")
	private WebElement primaryContent;

    public Clinic1023MulticentertrialcollaborationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1023MulticentertrialcollaborationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1023MulticentertrialcollaborationscreenScreen", "/generated/multi-center-trial-collaboration");
    }
}

