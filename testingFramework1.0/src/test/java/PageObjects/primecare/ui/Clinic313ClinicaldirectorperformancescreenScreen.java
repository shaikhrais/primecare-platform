package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic313ClinicaldirectorperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 313;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_performance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorperformance-screen')]")
	private WebElement clinicaldirectorperformanceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorperformance-btn-2')]")
	private WebElement clinicaldirectorperformanceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorperformance-title')]")
	private WebElement clinicaldirectorperformanceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorperformance-btn-1')]")
	private WebElement clinicaldirectorperformanceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorperformance-btn-3')]")
	private WebElement clinicaldirectorperformanceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorperformance-content')]")
	private WebElement clinicaldirectorperformanceContent;

    public Clinic313ClinicaldirectorperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic313ClinicaldirectorperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic313ClinicaldirectorperformancescreenScreen", "/offices/clinical/roles/clinical_director/performance");
    }
}

