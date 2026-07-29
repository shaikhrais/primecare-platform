package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth118FamilymembercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 118;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercompliance-btn-1')]")
	private WebElement familymembercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercompliance-btn-3')]")
	private WebElement familymembercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercompliance-screen')]")
	private WebElement familymembercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercompliance-title')]")
	private WebElement familymembercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercompliance-content')]")
	private WebElement familymembercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercompliance-btn-2')]")
	private WebElement familymembercomplianceBtn2;

    public Auth118FamilymembercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth118FamilymembercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth118FamilymembercompliancescreenScreen", "/common/family-member-compliance");
    }
}

