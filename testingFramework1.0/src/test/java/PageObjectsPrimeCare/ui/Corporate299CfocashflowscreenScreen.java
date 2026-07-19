package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate299CfocashflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 299;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_cashflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_cashflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_cashflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-btn-3')]")
	private WebElement cfocashflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-btn-2')]")
	private WebElement cfocashflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-content')]")
	private WebElement cfocashflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-loading')]")
	private WebElement cfocashflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-screen')]")
	private WebElement cfocashflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-btn-1')]")
	private WebElement cfocashflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocashflow-title')]")
	private WebElement cfocashflowTitle;

    public Corporate299CfocashflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate299CfocashflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate299CfocashflowscreenScreen", "/executive/cfo-cashflow");
    }
}
