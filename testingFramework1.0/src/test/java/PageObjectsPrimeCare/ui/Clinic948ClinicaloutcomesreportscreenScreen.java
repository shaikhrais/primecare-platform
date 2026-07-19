package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic948ClinicaloutcomesreportscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 948;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_outcomes_report-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_outcomes_report-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_outcomes_report-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_outcomes_report_iconbutton_button_1')]")
	private WebElement clinicalOutcomesReportIconbuttonButton1;

    public Clinic948ClinicaloutcomesreportscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic948ClinicaloutcomesreportscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic948ClinicaloutcomesreportscreenScreen", "/generated/clinical-outcomes-report");
    }
}
