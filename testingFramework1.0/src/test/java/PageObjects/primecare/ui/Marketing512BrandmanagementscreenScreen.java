package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Marketing512BrandmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 512;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-btn-3')]")
	private WebElement brandmanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-btn-1')]")
	private WebElement brandmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-screen')]")
	private WebElement brandmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-loading')]")
	private WebElement brandmanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-content')]")
	private WebElement brandmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-title')]")
	private WebElement brandmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brandmanagement-btn-2')]")
	private WebElement brandmanagementBtn2;

    public Marketing512BrandmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Marketing512BrandmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Marketing512BrandmanagementscreenScreen", "/management/brand-management");
    }
}

