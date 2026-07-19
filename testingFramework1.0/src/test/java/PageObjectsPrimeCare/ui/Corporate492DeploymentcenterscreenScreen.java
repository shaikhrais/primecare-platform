package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate492DeploymentcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 492;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deployment_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deployment_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deployment_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-screen')]")
	private WebElement deploymentcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-content')]")
	private WebElement deploymentcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-btn-1')]")
	private WebElement deploymentcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-btn-2')]")
	private WebElement deploymentcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-title')]")
	private WebElement deploymentcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-btn-3')]")
	private WebElement deploymentcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'deploymentcenter-loading')]")
	private WebElement deploymentcenterLoading;

    public Corporate492DeploymentcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate492DeploymentcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate492DeploymentcenterscreenScreen", "/executive/deployment-center");
    }
}
