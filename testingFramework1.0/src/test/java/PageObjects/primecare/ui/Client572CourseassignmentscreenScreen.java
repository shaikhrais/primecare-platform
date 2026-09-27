package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client572CourseassignmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 572;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_assignment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_assignment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_assignment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-btn-4')]")
	private WebElement courseassignmentBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-btn-2')]")
	private WebElement courseassignmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-btn-5')]")
	private WebElement courseassignmentBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-title')]")
	private WebElement courseassignmentTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-screen')]")
	private WebElement courseassignmentScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-loading')]")
	private WebElement courseassignmentLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-content')]")
	private WebElement courseassignmentContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-btn-1')]")
	private WebElement courseassignmentBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'courseassignment-btn-3')]")
	private WebElement courseassignmentBtn3;

    public Client572CourseassignmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client572CourseassignmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client572CourseassignmentscreenScreen", "/staff/course-assignment");
    }
}

