package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client530ApplicanttrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 530;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicant_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicant_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicant_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-btn-3')]")
	private WebElement applicanttrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-btn-1')]")
	private WebElement applicanttrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-content')]")
	private WebElement applicanttrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-screen')]")
	private WebElement applicanttrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-loading')]")
	private WebElement applicanttrackingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-btn-5')]")
	private WebElement applicanttrackingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-title')]")
	private WebElement applicanttrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-btn-2')]")
	private WebElement applicanttrackingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'applicanttracking-btn-4')]")
	private WebElement applicanttrackingBtn4;

    public Client530ApplicanttrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client530ApplicanttrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client530ApplicanttrackingscreenScreen", "/staff/applicant-tracking");
    }
}

