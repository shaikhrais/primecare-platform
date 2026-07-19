package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth95HswschedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 95;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_schedule-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswschedule-content')]")
	private WebElement hswscheduleContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswschedule-btn-1')]")
	private WebElement hswscheduleBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'request_schedule_swap')]")
	private WebElement requestScheduleSwap;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generate_travel_expense_report')]")
	private WebElement generateTravelExpenseReport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-visits-calendar-view')]")
	private WebElement dataCyHswVisitsCalendarView;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-client-map-locator')]")
	private WebElement dataCyHswClientMapLocator;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswschedule-screen')]")
	private WebElement hswscheduleScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-mileage-tracker-widget')]")
	private WebElement dataCyHswMileageTrackerWidget;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswschedule-title')]")
	private WebElement hswscheduleTitle;

    public Auth95HswschedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth95HswschedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth95HswschedulescreenScreen", "/clinical/hsw-schedule");
    }
}
