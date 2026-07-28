package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic741CooissueescalationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 741;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_issue_escalations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_issue_escalations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_issue_escalations-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooissueescalationsscreen-screen')]")
	private WebElement cooissueescalationsscreenScreen;

    public Clinic741CooissueescalationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic741CooissueescalationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic741CooissueescalationsscreenScreen", "/offices/corporate/roles/coo/issue-escalations");
    }
}

