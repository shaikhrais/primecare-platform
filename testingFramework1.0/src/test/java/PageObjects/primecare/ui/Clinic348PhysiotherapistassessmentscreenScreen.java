package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic348PhysiotherapistassessmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 348;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_assessment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_assessment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_assessment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistassessment-btn-1')]")
	private WebElement physiotherapistassessmentBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistassessment-screen')]")
	private WebElement physiotherapistassessmentScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistassessment-content')]")
	private WebElement physiotherapistassessmentContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistassessment-title')]")
	private WebElement physiotherapistassessmentTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistassessment-btn-2')]")
	private WebElement physiotherapistassessmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistassessment-btn-3')]")
	private WebElement physiotherapistassessmentBtn3;

    public Clinic348PhysiotherapistassessmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic348PhysiotherapistassessmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic348PhysiotherapistassessmentscreenScreen", "/offices/clinical/roles/physiotherapist/assessment");
    }
}

