package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic563ClinicalqualityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 563;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_quality-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_quality-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_quality-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-title')]")
	private WebElement clinicalqualityTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-btn-3')]")
	private WebElement clinicalqualityBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-screen')]")
	private WebElement clinicalqualityScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-loading')]")
	private WebElement clinicalqualityLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-btn-2')]")
	private WebElement clinicalqualityBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-content')]")
	private WebElement clinicalqualityContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalquality-btn-1')]")
	private WebElement clinicalqualityBtn1;

    public Clinic563ClinicalqualityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic563ClinicalqualityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic563ClinicalqualityscreenScreen", "/offices/clinical/roles/clinical_director/quality");
    }
}
