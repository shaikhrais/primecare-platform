package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate491ApimonitoringscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 491;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_monitoring-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_monitoring-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_monitoring-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-btn-2')]")
	private WebElement apimonitoringBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-loading')]")
	private WebElement apimonitoringLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-btn-1')]")
	private WebElement apimonitoringBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-title')]")
	private WebElement apimonitoringTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-screen')]")
	private WebElement apimonitoringScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-content')]")
	private WebElement apimonitoringContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apimonitoring-btn-3')]")
	private WebElement apimonitoringBtn3;

    public Corporate491ApimonitoringscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate491ApimonitoringscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate491ApimonitoringscreenScreen", "/executive/api-monitoring");
    }
}

