package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate481StaffingoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 481;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffing_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffing_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffing_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-content')]")
	private WebElement staffingoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-title')]")
	private WebElement staffingoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-loading')]")
	private WebElement staffingoverviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-btn-3')]")
	private WebElement staffingoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-btn-2')]")
	private WebElement staffingoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-btn-1')]")
	private WebElement staffingoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staffingoverview-screen')]")
	private WebElement staffingoverviewScreen;

    public Corporate481StaffingoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate481StaffingoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate481StaffingoverviewscreenScreen", "/executive/staffing-overview");
    }
}

