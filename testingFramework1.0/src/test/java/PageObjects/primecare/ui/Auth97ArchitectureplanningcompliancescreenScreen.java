package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth97ArchitectureplanningcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 97;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningcompliance-content')]")
	private WebElement architectureplanningcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningcompliance-btn-1')]")
	private WebElement architectureplanningcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningcompliance-screen')]")
	private WebElement architectureplanningcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningcompliance-btn-2')]")
	private WebElement architectureplanningcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningcompliance-title')]")
	private WebElement architectureplanningcomplianceTitle;

    public Auth97ArchitectureplanningcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth97ArchitectureplanningcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth97ArchitectureplanningcompliancescreenScreen", "/common/architecture-planning-compliance");
    }
}

