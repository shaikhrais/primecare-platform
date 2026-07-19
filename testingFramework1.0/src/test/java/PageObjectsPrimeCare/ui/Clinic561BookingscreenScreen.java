package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic561BookingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 561;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-loading')]")
	private WebElement bookingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-btn-1')]")
	private WebElement bookingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-btn-2')]")
	private WebElement bookingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'booking-btn-3')]")
	private WebElement bookingBtn3;

    public Clinic561BookingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic561BookingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic561BookingscreenScreen", "/offices/clinical/roles/intake_coordinator/booking");
    }
}
