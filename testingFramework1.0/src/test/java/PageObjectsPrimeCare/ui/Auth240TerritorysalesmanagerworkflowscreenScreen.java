package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth240TerritorysalesmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 240;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerworkflow-btn-1')]")
	private WebElement territorysalesmanagerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerworkflow-content')]")
	private WebElement territorysalesmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerworkflow-title')]")
	private WebElement territorysalesmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerworkflow-screen')]")
	private WebElement territorysalesmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerworkflow-btn-2')]")
	private WebElement territorysalesmanagerworkflowBtn2;

    public Auth240TerritorysalesmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth240TerritorysalesmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth240TerritorysalesmanagerworkflowscreenScreen", "/management/territory-sales-manager-workflow");
    }
}
