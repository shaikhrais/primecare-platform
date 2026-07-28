package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate485FinancialdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 485;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialdashboard-btn-1')]")
	private WebElement financialdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialdashboard-screen')]")
	private WebElement financialdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialdashboard-content')]")
	private WebElement financialdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialdashboard-btn-3')]")
	private WebElement financialdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialdashboard-btn-2')]")
	private WebElement financialdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialdashboard-title')]")
	private WebElement financialdashboardTitle;

    public Corporate485FinancialdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate485FinancialdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate485FinancialdashboardscreenScreen", "/executive/financial-dashboard");
    }
}

