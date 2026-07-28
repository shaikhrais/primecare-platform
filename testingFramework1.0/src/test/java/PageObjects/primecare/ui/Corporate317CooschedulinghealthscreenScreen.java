package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate317CooschedulinghealthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 317;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_scheduling_health-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_scheduling_health-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_scheduling_health-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooschedulinghealth-screen')]")
	private WebElement cooschedulinghealthScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooschedulinghealth-title')]")
	private WebElement cooschedulinghealthTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooschedulinghealth-btn-1')]")
	private WebElement cooschedulinghealthBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooschedulinghealth-content')]")
	private WebElement cooschedulinghealthContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooschedulinghealth-btn-2')]")
	private WebElement cooschedulinghealthBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooschedulinghealth-btn-3')]")
	private WebElement cooschedulinghealthBtn3;

    public Corporate317CooschedulinghealthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate317CooschedulinghealthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate317CooschedulinghealthscreenScreen", "/offices/corporate/roles/coo/scheduling-health");
    }
}

