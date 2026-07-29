package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth212HeadofbusdevcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 212;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevcompliance-btn-2')]")
	private WebElement headofbusdevcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevcompliance-content')]")
	private WebElement headofbusdevcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevcompliance-btn-1')]")
	private WebElement headofbusdevcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevcompliance-btn-3')]")
	private WebElement headofbusdevcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevcompliance-title')]")
	private WebElement headofbusdevcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevcompliance-screen')]")
	private WebElement headofbusdevcomplianceScreen;

    public Auth212HeadofbusdevcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth212HeadofbusdevcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth212HeadofbusdevcompliancescreenScreen", "/management/head-of-bus-dev-compliance");
    }
}

