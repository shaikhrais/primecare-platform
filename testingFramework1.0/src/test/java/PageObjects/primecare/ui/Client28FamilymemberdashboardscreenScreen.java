package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client28FamilymemberdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 28;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberdashboard-screen')]")
	private WebElement familymemberdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberdashboard-btn-2')]")
	private WebElement familymemberdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberdashboard-btn-3')]")
	private WebElement familymemberdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberdashboard-content')]")
	private WebElement familymemberdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberdashboard-title')]")
	private WebElement familymemberdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberdashboard-btn-1')]")
	private WebElement familymemberdashboardBtn1;

    public Client28FamilymemberdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client28FamilymemberdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client28FamilymemberdashboardscreenScreen", "/common/family-member-dashboard");
    }
}

