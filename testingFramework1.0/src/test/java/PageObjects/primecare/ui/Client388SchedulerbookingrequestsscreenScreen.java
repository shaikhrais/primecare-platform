package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client388SchedulerbookingrequestsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 388;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_booking_requests-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_booking_requests-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_booking_requests-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-btn-2')]")
	private WebElement schedulerbookingrequestsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-title')]")
	private WebElement schedulerbookingrequestsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-screen')]")
	private WebElement schedulerbookingrequestsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-btn-3')]")
	private WebElement schedulerbookingrequestsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-btn-5')]")
	private WebElement schedulerbookingrequestsBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-btn-1')]")
	private WebElement schedulerbookingrequestsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-btn-4')]")
	private WebElement schedulerbookingrequestsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerbookingrequests-content')]")
	private WebElement schedulerbookingrequestsContent;

    public Client388SchedulerbookingrequestsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client388SchedulerbookingrequestsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client388SchedulerbookingrequestsscreenScreen", "/staff/scheduler-booking-requests");
    }
}

