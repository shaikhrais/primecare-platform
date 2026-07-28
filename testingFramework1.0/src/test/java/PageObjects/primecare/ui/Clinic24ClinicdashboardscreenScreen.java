package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic24ClinicdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 24;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-loading')]")
	private WebElement clinicdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-btn-1')]")
	private WebElement clinicdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-screen')]")
	private WebElement clinicdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-title')]")
	private WebElement clinicdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-content')]")
	private WebElement clinicdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-btn-3')]")
	private WebElement clinicdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicdashboard-btn-2')]")
	private WebElement clinicdashboardBtn2;

    public Clinic24ClinicdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic24ClinicdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic24ClinicdashboardscreenScreen", "/offices/clinical/roles/clinical_director/clinic-dashboard");
    }
}

