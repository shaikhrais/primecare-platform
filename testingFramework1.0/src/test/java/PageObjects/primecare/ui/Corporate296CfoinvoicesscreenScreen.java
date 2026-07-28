package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate296CfoinvoicesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 296;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_invoices-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_invoices-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_invoices-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-loading')]")
	private WebElement cfoinvoicesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-btn-2')]")
	private WebElement cfoinvoicesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-btn-1')]")
	private WebElement cfoinvoicesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-screen')]")
	private WebElement cfoinvoicesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-title')]")
	private WebElement cfoinvoicesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-btn-3')]")
	private WebElement cfoinvoicesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoinvoices-content')]")
	private WebElement cfoinvoicesContent;

    public Corporate296CfoinvoicesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate296CfoinvoicesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate296CfoinvoicesscreenScreen", "/offices/corporate/roles/cfo/invoices");
    }
}

