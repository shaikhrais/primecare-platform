package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic926LeadpipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 926;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_pipeline-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_pipeline_screen_iconbutton_button_2')]")
	private WebElement leadPipelineScreenIconbuttonButton2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_pipeline_screen_iconbutton_button_1')]")
	private WebElement leadPipelineScreenIconbuttonButton1;

    public Clinic926LeadpipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic926LeadpipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic926LeadpipelinescreenScreen", "/generated/lead-pipeline");
    }
}

