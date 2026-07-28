package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class BusinessDevelopment506PartnershipmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 506;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagement-btn-1')]")
	private WebElement partnershipmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagement-content')]")
	private WebElement partnershipmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagement-btn-3')]")
	private WebElement partnershipmanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagement-title')]")
	private WebElement partnershipmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagement-btn-2')]")
	private WebElement partnershipmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagement-screen')]")
	private WebElement partnershipmanagementScreen;

    public BusinessDevelopment506PartnershipmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public BusinessDevelopment506PartnershipmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "BusinessDevelopment506PartnershipmanagementscreenScreen", "/management/partnership-management");
    }
}

