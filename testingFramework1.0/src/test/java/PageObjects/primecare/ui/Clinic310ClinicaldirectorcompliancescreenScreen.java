package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic310ClinicaldirectorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 310;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorcompliance-btn-2')]")
	private WebElement clinicaldirectorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorcompliance-screen')]")
	private WebElement clinicaldirectorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorcompliance-btn-1')]")
	private WebElement clinicaldirectorcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorcompliance-title')]")
	private WebElement clinicaldirectorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorcompliance-btn-3')]")
	private WebElement clinicaldirectorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorcompliance-content')]")
	private WebElement clinicaldirectorcomplianceContent;

    public Clinic310ClinicaldirectorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic310ClinicaldirectorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic310ClinicaldirectorcompliancescreenScreen", "/offices/clinical/roles/clinical_director/compliance-director");
    }
}

