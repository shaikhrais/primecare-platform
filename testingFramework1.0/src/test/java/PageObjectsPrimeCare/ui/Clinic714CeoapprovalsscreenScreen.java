package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic714CeoapprovalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 714;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_approvals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_approvals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_approvals-content')]")
	private WebElement primaryContent;

    public Clinic714CeoapprovalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic714CeoapprovalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic714CeoapprovalsscreenScreen", "/offices/corporate/roles/ceo/approvals");
    }
}
