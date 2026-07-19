package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client390ScheduleropenshiftsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 390;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_open_shifts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_open_shifts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_open_shifts-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-btn-3')]")
	private WebElement scheduleropenshiftsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-btn-4')]")
	private WebElement scheduleropenshiftsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-btn-2')]")
	private WebElement scheduleropenshiftsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-btn-1')]")
	private WebElement scheduleropenshiftsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-btn-5')]")
	private WebElement scheduleropenshiftsBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-title')]")
	private WebElement scheduleropenshiftsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-screen')]")
	private WebElement scheduleropenshiftsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleropenshifts-content')]")
	private WebElement scheduleropenshiftsContent;

    public Client390ScheduleropenshiftsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client390ScheduleropenshiftsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client390ScheduleropenshiftsscreenScreen", "/staff/scheduler-open-shifts");
    }
}
