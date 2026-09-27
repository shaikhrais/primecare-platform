package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic979ReceptionistvisitorsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 979;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_visitors-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_visitors-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_visitors-content')]")
	private WebElement primaryContent;

    public Clinic979ReceptionistvisitorsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic979ReceptionistvisitorsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic979ReceptionistvisitorsscreenScreen", "/generated/receptionist-visitors");
    }
}

