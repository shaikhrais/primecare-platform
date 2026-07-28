package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client579AppointmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 579;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-loading')]")
	private WebElement appointmentLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-btn-2')]")
	private WebElement appointmentBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-btn-3')]")
	private WebElement appointmentBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'appointment-btn-1')]")
	private WebElement appointmentBtn1;

    public Client579AppointmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client579AppointmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client579AppointmentscreenScreen", "/common/appointment");
    }
}

