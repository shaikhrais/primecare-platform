package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client583FamilyoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 583;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-content')]")
	private WebElement familyoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-screen')]")
	private WebElement familyoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-btn-1')]")
	private WebElement familyoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-btn-2')]")
	private WebElement familyoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-btn-3')]")
	private WebElement familyoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-title')]")
	private WebElement familyoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familyoverview-loading')]")
	private WebElement familyoverviewLoading;

    public Client583FamilyoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client583FamilyoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client583FamilyoverviewscreenScreen", "/common/family-overview");
    }
}
