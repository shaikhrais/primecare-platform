package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise515StaffmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 515;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-title')]")
	private WebElement staffmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-loading')]")
	private WebElement staffmanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-screen')]")
	private WebElement staffmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-btn-2')]")
	private WebElement staffmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-content')]")
	private WebElement staffmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-btn-1')]")
	private WebElement staffmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffmanagement-btn-3')]")
	private WebElement staffmanagementBtn3;

    public Franchise515StaffmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise515StaffmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise515StaffmanagementscreenScreen", "/executive/staff-management");
    }
}

