package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth228RegionalbdmworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 228;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmworkflow-title')]")
	private WebElement regionalbdmworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmworkflow-screen')]")
	private WebElement regionalbdmworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmworkflow-btn-2')]")
	private WebElement regionalbdmworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmworkflow-content')]")
	private WebElement regionalbdmworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmworkflow-btn-1')]")
	private WebElement regionalbdmworkflowBtn1;

    public Auth228RegionalbdmworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth228RegionalbdmworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth228RegionalbdmworkflowscreenScreen", "/management/regional-bdm-workflow");
    }
}

