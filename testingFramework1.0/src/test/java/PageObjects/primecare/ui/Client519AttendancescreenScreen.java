package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client519AttendancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 519;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-loading')]")
	private WebElement attendanceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-btn-2')]")
	private WebElement attendanceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-btn-3')]")
	private WebElement attendanceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'attendance-btn-1')]")
	private WebElement attendanceBtn1;

    public Client519AttendancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client519AttendancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client519AttendancescreenScreen", "/management/attendance");
    }
}

