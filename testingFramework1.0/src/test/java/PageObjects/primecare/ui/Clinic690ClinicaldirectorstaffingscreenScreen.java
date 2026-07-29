package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic690ClinicaldirectorstaffingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 690;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_staffing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_staffing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_staffing-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffingscreen-screen')]")
	private WebElement clinicaldirectorstaffingscreenScreen;

    public Clinic690ClinicaldirectorstaffingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic690ClinicaldirectorstaffingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic690ClinicaldirectorstaffingscreenScreen", "/generated/clinical-director-staffing");
    }
}

