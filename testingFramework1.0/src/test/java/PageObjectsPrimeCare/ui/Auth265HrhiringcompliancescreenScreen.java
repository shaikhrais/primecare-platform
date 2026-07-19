package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth265HrhiringcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 265;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-screen')]")
	private WebElement hrhiringcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-btn-5')]")
	private WebElement hrhiringcomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-btn-2')]")
	private WebElement hrhiringcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-title')]")
	private WebElement hrhiringcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-btn-3')]")
	private WebElement hrhiringcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-btn-1')]")
	private WebElement hrhiringcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-btn-4')]")
	private WebElement hrhiringcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcompliance-content')]")
	private WebElement hrhiringcomplianceContent;

    public Auth265HrhiringcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth265HrhiringcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth265HrhiringcompliancescreenScreen", "/staff/hr-hiring-compliance");
    }
}
