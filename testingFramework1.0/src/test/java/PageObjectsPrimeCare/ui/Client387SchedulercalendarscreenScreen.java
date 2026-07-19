package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client387SchedulercalendarscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 387;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_calendar-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_calendar-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_calendar-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-loading')]")
	private WebElement schedulercalendarLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-btn-1')]")
	private WebElement schedulercalendarBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-title')]")
	private WebElement schedulercalendarTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-btn-4')]")
	private WebElement schedulercalendarBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-btn-3')]")
	private WebElement schedulercalendarBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-btn-2')]")
	private WebElement schedulercalendarBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-content')]")
	private WebElement schedulercalendarContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-screen')]")
	private WebElement schedulercalendarScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercalendar-btn-5')]")
	private WebElement schedulercalendarBtn5;

    public Client387SchedulercalendarscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client387SchedulercalendarscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client387SchedulercalendarscreenScreen", "/staff/scheduler-calendar");
    }
}
