package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise516AppointmentoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 516;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointmentoverview-btn-2')]")
	private WebElement appointmentoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointmentoverview-btn-3')]")
	private WebElement appointmentoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointmentoverview-content')]")
	private WebElement appointmentoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointmentoverview-screen')]")
	private WebElement appointmentoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointmentoverview-btn-1')]")
	private WebElement appointmentoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointmentoverview-title')]")
	private WebElement appointmentoverviewTitle;

    public Franchise516AppointmentoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise516AppointmentoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise516AppointmentoverviewscreenScreen", "/executive/appointment-overview");
    }
}

