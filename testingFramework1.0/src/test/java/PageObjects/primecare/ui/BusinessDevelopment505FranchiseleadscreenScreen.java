package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class BusinessDevelopment505FranchiseleadscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 505;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_lead-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_lead-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_lead-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-content')]")
	private WebElement franchiseleadContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-btn-2')]")
	private WebElement franchiseleadBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-btn-1')]")
	private WebElement franchiseleadBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-screen')]")
	private WebElement franchiseleadScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-title')]")
	private WebElement franchiseleadTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-loading')]")
	private WebElement franchiseleadLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiselead-btn-3')]")
	private WebElement franchiseleadBtn3;

    public BusinessDevelopment505FranchiseleadscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public BusinessDevelopment505FranchiseleadscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "BusinessDevelopment505FranchiseleadscreenScreen", "/management/franchise-lead");
    }
}

