package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client551MassageassessmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 551;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massage_assessment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massage_assessment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massage_assessment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-content')]")
	private WebElement massageassessmentContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-btn-2')]")
	private WebElement massageassessmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-btn-1')]")
	private WebElement massageassessmentBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-title')]")
	private WebElement massageassessmentTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-btn-3')]")
	private WebElement massageassessmentBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-screen')]")
	private WebElement massageassessmentScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'massageassessment-loading')]")
	private WebElement massageassessmentLoading;

    public Client551MassageassessmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client551MassageassessmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client551MassageassessmentscreenScreen", "/offices/clinical/roles/rmt/massage-assessment");
    }
}

