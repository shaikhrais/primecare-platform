package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client526InvoicemanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 526;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoice_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoice_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoice_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-btn-5')]")
	private WebElement invoicemanagementBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-screen')]")
	private WebElement invoicemanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-loading')]")
	private WebElement invoicemanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-btn-2')]")
	private WebElement invoicemanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-content')]")
	private WebElement invoicemanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-btn-4')]")
	private WebElement invoicemanagementBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-btn-1')]")
	private WebElement invoicemanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-btn-3')]")
	private WebElement invoicemanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'invoicemanagement-title')]")
	private WebElement invoicemanagementTitle;

    public Client526InvoicemanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client526InvoicemanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client526InvoicemanagementscreenScreen", "/staff/invoice-management");
    }
}
