package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1034TelehealthconsultationroomscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1034;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telehealth_consultation_room-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telehealth_consultation_room-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telehealth_consultation_room-content')]")
	private WebElement primaryContent;

    public Clinic1034TelehealthconsultationroomscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1034TelehealthconsultationroomscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1034TelehealthconsultationroomscreenScreen", "/generated/telehealth-consultation-room");
    }
}
