package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate295CfopayrollscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 295;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_payroll-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_payroll-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_payroll-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-btn-1')]")
	private WebElement cfopayrollBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-title')]")
	private WebElement cfopayrollTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-btn-3')]")
	private WebElement cfopayrollBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-btn-2')]")
	private WebElement cfopayrollBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-screen')]")
	private WebElement cfopayrollScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-loading')]")
	private WebElement cfopayrollLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfopayroll-content')]")
	private WebElement cfopayrollContent;

    public Corporate295CfopayrollscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate295CfopayrollscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate295CfopayrollscreenScreen", "/offices/corporate/roles/cfo/payroll");
    }
}

