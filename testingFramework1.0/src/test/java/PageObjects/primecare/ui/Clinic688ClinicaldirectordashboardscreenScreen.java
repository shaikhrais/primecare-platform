package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic688ClinicaldirectordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 688;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_dashboard_elevatedbutton_button_1')]")
	private WebElement clinicalDirectorDashboardElevatedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_dashboard_iconbutton_button_1')]")
	private WebElement clinicalDirectorDashboardIconbuttonButton1;

    public Clinic688ClinicaldirectordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic688ClinicaldirectordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic688ClinicaldirectordashboardscreenScreen", "/offices/clinical/roles/clinical_director/dashboard");
    }
}

