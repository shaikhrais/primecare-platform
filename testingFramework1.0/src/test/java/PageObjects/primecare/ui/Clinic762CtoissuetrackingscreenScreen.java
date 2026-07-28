package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic762CtoissuetrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 762;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_issue_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_issue_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_issue_tracking-content')]")
	private WebElement primaryContent;

    public Clinic762CtoissuetrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic762CtoissuetrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic762CtoissuetrackingscreenScreen", "/offices/corporate/roles/cto/issue-tracking");
    }
}

