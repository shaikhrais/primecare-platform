package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic73RnfieldsupervisordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 73;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-btn-5')]")
	private WebElement rnfieldsupervisordashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-btn-3')]")
	private WebElement rnfieldsupervisordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-title')]")
	private WebElement rnfieldsupervisordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-screen')]")
	private WebElement rnfieldsupervisordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-content')]")
	private WebElement rnfieldsupervisordashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-btn-4')]")
	private WebElement rnfieldsupervisordashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-btn-2')]")
	private WebElement rnfieldsupervisordashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnfieldsupervisordashboard-btn-1')]")
	private WebElement rnfieldsupervisordashboardBtn1;

    public Clinic73RnfieldsupervisordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic73RnfieldsupervisordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic73RnfieldsupervisordashboardscreenScreen", "/rn/rn-field-supervisor-dashboard");
    }
}

