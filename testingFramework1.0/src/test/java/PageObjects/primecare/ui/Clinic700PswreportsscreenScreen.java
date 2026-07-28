package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic700PswreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 700;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswreports-btn-generate')]")
	private WebElement pswreportsBtnGenerate;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswreports-content')]")
	private WebElement pswreportsContent;

    public Clinic700PswreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic700PswreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic700PswreportsscreenScreen", "/generated/psw-reports");
    }
}

