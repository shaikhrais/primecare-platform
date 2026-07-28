package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client529RefundmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 529;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refund_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refund_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refund_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-content')]")
	private WebElement refundmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-screen')]")
	private WebElement refundmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-btn-4')]")
	private WebElement refundmanagementBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-btn-3')]")
	private WebElement refundmanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-btn-5')]")
	private WebElement refundmanagementBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-btn-1')]")
	private WebElement refundmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-btn-2')]")
	private WebElement refundmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-loading')]")
	private WebElement refundmanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'refundmanagement-title')]")
	private WebElement refundmanagementTitle;

    public Client529RefundmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client529RefundmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client529RefundmanagementscreenScreen", "/staff/refund-management");
    }
}

