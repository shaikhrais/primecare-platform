package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic371RnpatientchartingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 371;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_patient_charting-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_patient_charting-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_patient_charting-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-title')]")
	private WebElement rnpatientchartingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-content')]")
	private WebElement rnpatientchartingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-btn-3')]")
	private WebElement rnpatientchartingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-loading')]")
	private WebElement rnpatientchartingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-btn-1')]")
	private WebElement rnpatientchartingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-screen')]")
	private WebElement rnpatientchartingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnpatientcharting-btn-2')]")
	private WebElement rnpatientchartingBtn2;

    public Clinic371RnpatientchartingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic371RnpatientchartingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic371RnpatientchartingscreenScreen", "/offices/clinical/roles/rn/patient-charting");
    }
}

