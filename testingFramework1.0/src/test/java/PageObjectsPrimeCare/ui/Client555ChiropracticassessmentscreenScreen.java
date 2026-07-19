package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client555ChiropracticassessmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 555;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractic_assessment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractic_assessment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractic_assessment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticassessment-title')]")
	private WebElement chiropracticassessmentTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticassessment-btn-2')]")
	private WebElement chiropracticassessmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticassessment-screen')]")
	private WebElement chiropracticassessmentScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticassessment-content')]")
	private WebElement chiropracticassessmentContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticassessment-btn-1')]")
	private WebElement chiropracticassessmentBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticassessment-btn-3')]")
	private WebElement chiropracticassessmentBtn3;

    public Client555ChiropracticassessmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client555ChiropracticassessmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client555ChiropracticassessmentscreenScreen", "/offices/clinical/roles/chiropractor/chiropractic-assessment");
    }
}
