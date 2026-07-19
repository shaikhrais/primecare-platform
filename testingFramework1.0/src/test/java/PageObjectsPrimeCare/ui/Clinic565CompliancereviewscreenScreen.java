package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic565CompliancereviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 565;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-btn-2')]")
	private WebElement compliancereviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-screen')]")
	private WebElement compliancereviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-loading')]")
	private WebElement compliancereviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-btn-3')]")
	private WebElement compliancereviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-content')]")
	private WebElement compliancereviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-title')]")
	private WebElement compliancereviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancereview-btn-1')]")
	private WebElement compliancereviewBtn1;

    public Clinic565CompliancereviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic565CompliancereviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic565CompliancereviewscreenScreen", "/offices/clinical/roles/clinical_director/compliance-review");
    }
}
