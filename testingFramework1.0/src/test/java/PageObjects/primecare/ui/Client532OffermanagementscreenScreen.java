package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client532OffermanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 532;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offer_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offer_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offer_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-screen')]")
	private WebElement offermanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-btn-5')]")
	private WebElement offermanagementBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-loading')]")
	private WebElement offermanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-content')]")
	private WebElement offermanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-title')]")
	private WebElement offermanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-btn-1')]")
	private WebElement offermanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-btn-3')]")
	private WebElement offermanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-btn-4')]")
	private WebElement offermanagementBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'offermanagement-btn-2')]")
	private WebElement offermanagementBtn2;

    public Client532OffermanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client532OffermanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client532OffermanagementscreenScreen", "/staff/offer-management");
    }
}

