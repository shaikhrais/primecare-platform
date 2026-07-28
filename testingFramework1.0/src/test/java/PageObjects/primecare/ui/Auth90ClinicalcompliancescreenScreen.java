package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth90ClinicalcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 90;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalcompliance-title')]")
	private WebElement clinicalcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalcompliance-btn-1')]")
	private WebElement clinicalcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalcompliance-btn-2')]")
	private WebElement clinicalcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalcompliance-btn-3')]")
	private WebElement clinicalcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalcompliance-screen')]")
	private WebElement clinicalcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalcompliance-content')]")
	private WebElement clinicalcomplianceContent;

    public Auth90ClinicalcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth90ClinicalcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth90ClinicalcompliancescreenScreen", "/offices/clinical/roles/clinical_director/compliance");
    }
}

