package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth180FinancedirectorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 180;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorworkflow-content')]")
	private WebElement financedirectorworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorworkflow-screen')]")
	private WebElement financedirectorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorworkflow-title')]")
	private WebElement financedirectorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorworkflow-btn-2')]")
	private WebElement financedirectorworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorworkflow-btn-1')]")
	private WebElement financedirectorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorworkflow-btn-3')]")
	private WebElement financedirectorworkflowBtn3;

    public Auth180FinancedirectorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth180FinancedirectorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth180FinancedirectorworkflowscreenScreen", "/executive/finance-director-workflow");
    }
}

