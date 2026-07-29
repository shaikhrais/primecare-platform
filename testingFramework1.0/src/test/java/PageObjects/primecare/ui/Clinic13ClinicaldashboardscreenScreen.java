package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic13ClinicaldashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 13;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic13ClinicaldashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic13ClinicaldashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic13ClinicaldashboardscreenScreen", "/offices/clinical/roles/clinical_director/dashboard-dup-1");
    }
}

