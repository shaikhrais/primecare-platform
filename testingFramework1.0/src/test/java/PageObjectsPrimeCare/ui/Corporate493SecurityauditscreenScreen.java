package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate493SecurityauditscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 493;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_audit-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_audit-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_audit-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-btn-2')]")
	private WebElement securityauditBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-btn-3')]")
	private WebElement securityauditBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-title')]")
	private WebElement securityauditTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-loading')]")
	private WebElement securityauditLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-btn-1')]")
	private WebElement securityauditBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-content')]")
	private WebElement securityauditContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'securityaudit-screen')]")
	private WebElement securityauditScreen;

    public Corporate493SecurityauditscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate493SecurityauditscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate493SecurityauditscreenScreen", "/executive/security-audit");
    }
}
