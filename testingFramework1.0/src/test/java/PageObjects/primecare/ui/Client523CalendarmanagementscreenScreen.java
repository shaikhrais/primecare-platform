package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client523CalendarmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 523;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendar_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendar_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendar_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-btn-2')]")
	private WebElement calendarmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-content')]")
	private WebElement calendarmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-btn-4')]")
	private WebElement calendarmanagementBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-btn-1')]")
	private WebElement calendarmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-btn-5')]")
	private WebElement calendarmanagementBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-screen')]")
	private WebElement calendarmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-btn-3')]")
	private WebElement calendarmanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'calendarmanagement-title')]")
	private WebElement calendarmanagementTitle;

    public Client523CalendarmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client523CalendarmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client523CalendarmanagementscreenScreen", "/staff/calendar-management");
    }
}

