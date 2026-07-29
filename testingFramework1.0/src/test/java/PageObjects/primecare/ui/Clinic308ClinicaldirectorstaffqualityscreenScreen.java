package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic308ClinicaldirectorstaffqualityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 308;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_staff_quality-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_staff_quality-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_staff_quality-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffquality-content')]")
	private WebElement clinicaldirectorstaffqualityContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffquality-title')]")
	private WebElement clinicaldirectorstaffqualityTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffquality-btn-2')]")
	private WebElement clinicaldirectorstaffqualityBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffquality-btn-1')]")
	private WebElement clinicaldirectorstaffqualityBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffquality-btn-3')]")
	private WebElement clinicaldirectorstaffqualityBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorstaffquality-screen')]")
	private WebElement clinicaldirectorstaffqualityScreen;

    public Clinic308ClinicaldirectorstaffqualityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic308ClinicaldirectorstaffqualityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic308ClinicaldirectorstaffqualityscreenScreen", "/offices/clinical/roles/clinical_director/staff-quality");
    }
}

