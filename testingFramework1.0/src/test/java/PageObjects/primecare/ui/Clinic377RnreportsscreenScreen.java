package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic377RnreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 377;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-content')]")
	private WebElement rnreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-btn-2')]")
	private WebElement rnreportsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-btn-3')]")
	private WebElement rnreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-loading')]")
	private WebElement rnreportsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-title')]")
	private WebElement rnreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-screen')]")
	private WebElement rnreportsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnreports-btn-1')]")
	private WebElement rnreportsBtn1;

    public Clinic377RnreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic377RnreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic377RnreportsscreenScreen", "/offices/clinical/roles/rn/rn-reports");
    }
}

