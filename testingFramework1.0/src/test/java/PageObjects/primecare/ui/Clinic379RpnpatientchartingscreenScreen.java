package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic379RpnpatientchartingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 379;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_patient_charting-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_patient_charting-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_patient_charting-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnpatientcharting-btn-2')]")
	private WebElement rpnpatientchartingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnpatientcharting-title')]")
	private WebElement rpnpatientchartingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnpatientcharting-btn-3')]")
	private WebElement rpnpatientchartingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnpatientcharting-screen')]")
	private WebElement rpnpatientchartingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnpatientcharting-content')]")
	private WebElement rpnpatientchartingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnpatientcharting-btn-1')]")
	private WebElement rpnpatientchartingBtn1;

    public Clinic379RpnpatientchartingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic379RpnpatientchartingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic379RpnpatientchartingscreenScreen", "/offices/clinical/roles/rpn/patient-charting");
    }
}

