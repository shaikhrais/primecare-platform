package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic978ReceptionistcallsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 978;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_calls-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_calls-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_calls-content')]")
	private WebElement primaryContent;

    public Clinic978ReceptionistcallsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic978ReceptionistcallsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic978ReceptionistcallsscreenScreen", "/generated/receptionist-calls");
    }
}
