package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth239TerritorysalesmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 239;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagercompliance-title')]")
	private WebElement territorysalesmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagercompliance-btn-2')]")
	private WebElement territorysalesmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagercompliance-content')]")
	private WebElement territorysalesmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagercompliance-screen')]")
	private WebElement territorysalesmanagercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagercompliance-btn-1')]")
	private WebElement territorysalesmanagercomplianceBtn1;

    public Auth239TerritorysalesmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth239TerritorysalesmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth239TerritorysalesmanagercompliancescreenScreen", "/management/territory-sales-manager-compliance");
    }
}
