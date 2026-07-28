package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client553HomecareplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 553;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'home_care_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'home_care_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'home_care_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-title')]")
	private WebElement homecareplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-btn-3')]")
	private WebElement homecareplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-screen')]")
	private WebElement homecareplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-content')]")
	private WebElement homecareplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-loading')]")
	private WebElement homecareplanLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-btn-2')]")
	private WebElement homecareplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'homecareplan-btn-1')]")
	private WebElement homecareplanBtn1;

    public Client553HomecareplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client553HomecareplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client553HomecareplanscreenScreen", "/offices/clinical/roles/rmt/home-care-plan");
    }
}

