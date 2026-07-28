package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic312ClinicaldirectorapprovalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 312;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_approvals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_approvals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_approvals-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorapprovals-content')]")
	private WebElement clinicaldirectorapprovalsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorapprovals-screen')]")
	private WebElement clinicaldirectorapprovalsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorapprovals-btn-2')]")
	private WebElement clinicaldirectorapprovalsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorapprovals-btn-1')]")
	private WebElement clinicaldirectorapprovalsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorapprovals-btn-3')]")
	private WebElement clinicaldirectorapprovalsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorapprovals-title')]")
	private WebElement clinicaldirectorapprovalsTitle;

    public Clinic312ClinicaldirectorapprovalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic312ClinicaldirectorapprovalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic312ClinicaldirectorapprovalsscreenScreen", "/offices/clinical/roles/clinical_director/approvals");
    }
}

