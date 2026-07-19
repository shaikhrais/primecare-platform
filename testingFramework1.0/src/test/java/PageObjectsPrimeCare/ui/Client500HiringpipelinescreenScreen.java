package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client500HiringpipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 500;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiring_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiring_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiring_pipeline-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-screen')]")
	private WebElement hiringpipelineScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-title')]")
	private WebElement hiringpipelineTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-btn-1')]")
	private WebElement hiringpipelineBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-btn-2')]")
	private WebElement hiringpipelineBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-btn-3')]")
	private WebElement hiringpipelineBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-content')]")
	private WebElement hiringpipelineContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hiringpipeline-loading')]")
	private WebElement hiringpipelineLoading;

    public Client500HiringpipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client500HiringpipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client500HiringpipelinescreenScreen", "/management/hiring-pipeline");
    }
}
