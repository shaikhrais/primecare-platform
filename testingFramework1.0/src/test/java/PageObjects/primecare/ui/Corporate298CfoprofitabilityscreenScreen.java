package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate298CfoprofitabilityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 298;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_profitability-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_profitability-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_profitability-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-btn-2')]")
	private WebElement cfoprofitabilityBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-title')]")
	private WebElement cfoprofitabilityTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-loading')]")
	private WebElement cfoprofitabilityLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-content')]")
	private WebElement cfoprofitabilityContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-btn-1')]")
	private WebElement cfoprofitabilityBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-btn-3')]")
	private WebElement cfoprofitabilityBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoprofitability-screen')]")
	private WebElement cfoprofitabilityScreen;

    public Corporate298CfoprofitabilityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate298CfoprofitabilityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate298CfoprofitabilityscreenScreen", "/offices/corporate/roles/cfo/profitability");
    }
}

