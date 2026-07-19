package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth126InfrastructureanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 126;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-loading')]")
	private WebElement infrastructureanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-screen')]")
	private WebElement infrastructureanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-btn-2')]")
	private WebElement infrastructureanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-btn-1')]")
	private WebElement infrastructureanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-btn-3')]")
	private WebElement infrastructureanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-title')]")
	private WebElement infrastructureanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureanalytics-content')]")
	private WebElement infrastructureanalyticsContent;

    public Auth126InfrastructureanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth126InfrastructureanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth126InfrastructureanalyticsscreenScreen", "/common/infrastructure-analytics");
    }
}
