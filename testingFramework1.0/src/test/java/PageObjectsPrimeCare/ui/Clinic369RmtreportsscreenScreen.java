package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic369RmtreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 369;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-btn-3')]")
	private WebElement rmtreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-btn-1')]")
	private WebElement rmtreportsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-loading')]")
	private WebElement rmtreportsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-screen')]")
	private WebElement rmtreportsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-title')]")
	private WebElement rmtreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-content')]")
	private WebElement rmtreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtreports-btn-2')]")
	private WebElement rmtreportsBtn2;

    public Clinic369RmtreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic369RmtreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic369RmtreportsscreenScreen", "/offices/clinical/roles/rmt/reports");
    }
}
