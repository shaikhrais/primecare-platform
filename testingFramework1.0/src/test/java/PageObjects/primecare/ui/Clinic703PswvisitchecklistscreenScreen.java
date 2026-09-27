package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic703PswvisitchecklistscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 703;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_visit_checklist-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_visit_checklist-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_visit_checklist-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitchecklistscreen-screen')]")
	private WebElement pswvisitchecklistscreenScreen;

    public Clinic703PswvisitchecklistscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic703PswvisitchecklistscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic703PswvisitchecklistscreenScreen", "/generated/psw-visit-checklist");
    }
}

