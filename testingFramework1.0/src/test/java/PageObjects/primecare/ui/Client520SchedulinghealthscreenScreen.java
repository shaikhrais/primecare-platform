package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client520SchedulinghealthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 520;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_health-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_health-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_health-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-btn-2')]")
	private WebElement schedulinghealthBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-content')]")
	private WebElement schedulinghealthContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-screen')]")
	private WebElement schedulinghealthScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-loading')]")
	private WebElement schedulinghealthLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-btn-3')]")
	private WebElement schedulinghealthBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-btn-1')]")
	private WebElement schedulinghealthBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulinghealth-title')]")
	private WebElement schedulinghealthTitle;

    public Client520SchedulinghealthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client520SchedulinghealthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client520SchedulinghealthscreenScreen", "/management/scheduling-health");
    }
}

