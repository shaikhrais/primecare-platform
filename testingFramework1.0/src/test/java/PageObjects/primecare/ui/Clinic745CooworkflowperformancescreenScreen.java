package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic745CooworkflowperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 745;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow_performance-content')]")
	private WebElement primaryContent;

    public Clinic745CooworkflowperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic745CooworkflowperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic745CooworkflowperformancescreenScreen", "/offices/corporate/roles/coo/workflow-performance");
    }
}

