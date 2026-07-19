package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic670ClientbookappointmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 670;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_book_appointment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_book_appointment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_book_appointment-content')]")
	private WebElement primaryContent;

    public Clinic670ClientbookappointmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic670ClientbookappointmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic670ClientbookappointmentscreenScreen", "/generated/client-book-appointment");
    }
}
