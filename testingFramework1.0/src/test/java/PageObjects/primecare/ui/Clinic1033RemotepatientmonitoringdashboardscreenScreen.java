package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1033RemotepatientmonitoringdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1033;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'remote_patient_monitoring_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'remote_patient_monitoring_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'remote_patient_monitoring_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic1033RemotepatientmonitoringdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1033RemotepatientmonitoringdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1033RemotepatientmonitoringdashboardscreenScreen", "/generated/remote-patient-monitoring-dashboard");
    }
}

