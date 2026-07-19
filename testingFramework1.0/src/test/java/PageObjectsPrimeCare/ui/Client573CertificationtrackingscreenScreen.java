package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client573CertificationtrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 573;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-btn-4')]")
	private WebElement certificationtrackingBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-btn-5')]")
	private WebElement certificationtrackingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-screen')]")
	private WebElement certificationtrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-btn-3')]")
	private WebElement certificationtrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-btn-1')]")
	private WebElement certificationtrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-content')]")
	private WebElement certificationtrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-title')]")
	private WebElement certificationtrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certificationtracking-btn-2')]")
	private WebElement certificationtrackingBtn2;

    public Client573CertificationtrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client573CertificationtrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client573CertificationtrackingscreenScreen", "/staff/certification-tracking");
    }
}
