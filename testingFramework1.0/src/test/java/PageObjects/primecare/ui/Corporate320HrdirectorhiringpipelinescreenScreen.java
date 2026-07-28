package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate320HrdirectorhiringpipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 320;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_hiring_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_hiring_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_hiring_pipeline-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorhiringpipeline-btn-2')]")
	private WebElement hrdirectorhiringpipelineBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorhiringpipeline-btn-1')]")
	private WebElement hrdirectorhiringpipelineBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorhiringpipeline-content')]")
	private WebElement hrdirectorhiringpipelineContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorhiringpipeline-title')]")
	private WebElement hrdirectorhiringpipelineTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorhiringpipeline-btn-3')]")
	private WebElement hrdirectorhiringpipelineBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorhiringpipeline-screen')]")
	private WebElement hrdirectorhiringpipelineScreen;

    public Corporate320HrdirectorhiringpipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate320HrdirectorhiringpipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate320HrdirectorhiringpipelinescreenScreen", "/executive/hr-director-hiring-pipeline");
    }
}

