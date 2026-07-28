package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic365RmtassessmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 365;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_assessment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_assessment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_assessment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-btn-3')]")
	private WebElement rmtassessmentBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-btn-2')]")
	private WebElement rmtassessmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-btn-1')]")
	private WebElement rmtassessmentBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-content')]")
	private WebElement rmtassessmentContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-loading')]")
	private WebElement rmtassessmentLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-title')]")
	private WebElement rmtassessmentTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtassessment-screen')]")
	private WebElement rmtassessmentScreen;

    public Clinic365RmtassessmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic365RmtassessmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic365RmtassessmentscreenScreen", "/offices/clinical/roles/rmt/assessment");
    }
}

