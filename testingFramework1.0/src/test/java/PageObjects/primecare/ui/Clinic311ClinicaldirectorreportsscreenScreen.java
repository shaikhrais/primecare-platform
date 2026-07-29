package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic311ClinicaldirectorreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 311;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorreports-btn-2')]")
	private WebElement clinicaldirectorreportsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorreports-content')]")
	private WebElement clinicaldirectorreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorreports-title')]")
	private WebElement clinicaldirectorreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorreports-btn-1')]")
	private WebElement clinicaldirectorreportsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorreports-btn-3')]")
	private WebElement clinicaldirectorreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorreports-screen')]")
	private WebElement clinicaldirectorreportsScreen;

    public Clinic311ClinicaldirectorreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic311ClinicaldirectorreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic311ClinicaldirectorreportsscreenScreen", "/offices/clinical/roles/clinical_director/reports");
    }
}

