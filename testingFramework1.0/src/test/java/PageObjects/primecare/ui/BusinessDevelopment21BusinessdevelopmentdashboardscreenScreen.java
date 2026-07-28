package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class BusinessDevelopment21BusinessdevelopmentdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 21;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentdashboard-btn-1')]")
	private WebElement businessdevelopmentdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentdashboard-title')]")
	private WebElement businessdevelopmentdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentdashboard-btn-3')]")
	private WebElement businessdevelopmentdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentdashboard-btn-2')]")
	private WebElement businessdevelopmentdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentdashboard-content')]")
	private WebElement businessdevelopmentdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentdashboard-screen')]")
	private WebElement businessdevelopmentdashboardScreen;

    public BusinessDevelopment21BusinessdevelopmentdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public BusinessDevelopment21BusinessdevelopmentdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "BusinessDevelopment21BusinessdevelopmentdashboardscreenScreen", "/common/business-development-dashboard");
    }
}

