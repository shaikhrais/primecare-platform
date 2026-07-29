package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic951OperationalefficiencymetricsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 951;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operational_efficiency_metrics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operational_efficiency_metrics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operational_efficiency_metrics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operational_efficiency_metrics_iconbutton_button_1')]")
	private WebElement operationalEfficiencyMetricsIconbuttonButton1;

    public Clinic951OperationalefficiencymetricsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic951OperationalefficiencymetricsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic951OperationalefficiencymetricsscreenScreen", "/generated/operational-efficiency-metrics");
    }
}

