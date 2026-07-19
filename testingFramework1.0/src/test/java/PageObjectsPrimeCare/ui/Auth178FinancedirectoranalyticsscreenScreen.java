package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth178FinancedirectoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 178;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectoranalytics-btn-2')]")
	private WebElement financedirectoranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectoranalytics-content')]")
	private WebElement financedirectoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectoranalytics-btn-1')]")
	private WebElement financedirectoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectoranalytics-title')]")
	private WebElement financedirectoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectoranalytics-btn-3')]")
	private WebElement financedirectoranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectoranalytics-screen')]")
	private WebElement financedirectoranalyticsScreen;

    public Auth178FinancedirectoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth178FinancedirectoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth178FinancedirectoranalyticsscreenScreen", "/executive/finance-director-analytics");
    }
}
