package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth215HeadofmarketingcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 215;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingcompliance-content')]")
	private WebElement headofmarketingcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingcompliance-title')]")
	private WebElement headofmarketingcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingcompliance-btn-2')]")
	private WebElement headofmarketingcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingcompliance-btn-3')]")
	private WebElement headofmarketingcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingcompliance-screen')]")
	private WebElement headofmarketingcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingcompliance-btn-1')]")
	private WebElement headofmarketingcomplianceBtn1;

    public Auth215HeadofmarketingcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth215HeadofmarketingcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth215HeadofmarketingcompliancescreenScreen", "/management/head-of-marketing-compliance");
    }
}

