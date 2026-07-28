package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic303ChiropractorassessmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 303;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_assessment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_assessment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_assessment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorassessment-screen')]")
	private WebElement chiropractorassessmentScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorassessment-content')]")
	private WebElement chiropractorassessmentContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorassessment-btn-2')]")
	private WebElement chiropractorassessmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorassessment-btn-1')]")
	private WebElement chiropractorassessmentBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorassessment-btn-3')]")
	private WebElement chiropractorassessmentBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorassessment-title')]")
	private WebElement chiropractorassessmentTitle;

    public Clinic303ChiropractorassessmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic303ChiropractorassessmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic303ChiropractorassessmentscreenScreen", "/offices/clinical/roles/chiropractor/assessment");
    }
}

