package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic385RpnreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 385;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-title')]")
	private WebElement rpnreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-loading')]")
	private WebElement rpnreportsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-btn-3')]")
	private WebElement rpnreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-btn-2')]")
	private WebElement rpnreportsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-screen')]")
	private WebElement rpnreportsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-btn-1')]")
	private WebElement rpnreportsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnreports-content')]")
	private WebElement rpnreportsContent;

    public Clinic385RpnreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic385RpnreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic385RpnreportsscreenScreen", "/offices/clinical/roles/rpn/rpn-reports");
    }
}
