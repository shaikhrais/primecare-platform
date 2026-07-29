package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client496AuditreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 496;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-btn-3')]")
	private WebElement auditreviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-loading')]")
	private WebElement auditreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-btn-2')]")
	private WebElement auditreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-btn-1')]")
	private WebElement auditreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-content')]")
	private WebElement auditreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-title')]")
	private WebElement auditreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'auditreview-screen')]")
	private WebElement auditreviewScreen;

    public Client496AuditreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client496AuditreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client496AuditreviewscreenScreen", "/management/audit-review");
    }
}

