package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate490SystemhealthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 490;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_health-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_health-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_health-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-title')]")
	private WebElement systemhealthTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-btn-2')]")
	private WebElement systemhealthBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-btn-1')]")
	private WebElement systemhealthBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-btn-3')]")
	private WebElement systemhealthBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-content')]")
	private WebElement systemhealthContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-screen')]")
	private WebElement systemhealthScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemhealth-loading')]")
	private WebElement systemhealthLoading;

    public Corporate490SystemhealthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate490SystemhealthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate490SystemhealthscreenScreen", "/executive/system-health");
    }
}
