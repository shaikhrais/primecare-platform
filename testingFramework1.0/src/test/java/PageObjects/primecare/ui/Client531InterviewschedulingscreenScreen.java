package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client531InterviewschedulingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 531;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interview_scheduling-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interview_scheduling-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interview_scheduling-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-btn-1')]")
	private WebElement interviewschedulingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-btn-2')]")
	private WebElement interviewschedulingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-title')]")
	private WebElement interviewschedulingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-btn-5')]")
	private WebElement interviewschedulingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-screen')]")
	private WebElement interviewschedulingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-btn-4')]")
	private WebElement interviewschedulingBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-btn-3')]")
	private WebElement interviewschedulingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'interviewscheduling-content')]")
	private WebElement interviewschedulingContent;

    public Client531InterviewschedulingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client531InterviewschedulingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client531InterviewschedulingscreenScreen", "/staff/interview-scheduling");
    }
}

