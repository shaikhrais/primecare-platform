package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic673ClientmyappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 673;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_my_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_my_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_my_appointments-content')]")
	private WebElement primaryContent;

    public Clinic673ClientmyappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic673ClientmyappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic673ClientmyappointmentsscreenScreen", "/generated/client-my-appointments");
    }
}
