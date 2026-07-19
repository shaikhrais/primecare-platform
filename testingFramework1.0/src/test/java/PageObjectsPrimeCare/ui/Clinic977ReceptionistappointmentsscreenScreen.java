package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic977ReceptionistappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 977;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_appointments-content')]")
	private WebElement primaryContent;

    public Clinic977ReceptionistappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic977ReceptionistappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic977ReceptionistappointmentsscreenScreen", "/generated/receptionist-appointments");
    }
}
