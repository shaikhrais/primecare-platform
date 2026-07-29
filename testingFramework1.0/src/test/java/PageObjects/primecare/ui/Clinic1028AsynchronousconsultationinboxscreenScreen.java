package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1028AsynchronousconsultationinboxscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1028;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'asynchronous_consultation_inbox-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'asynchronous_consultation_inbox-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'asynchronous_consultation_inbox-content')]")
	private WebElement primaryContent;

    public Clinic1028AsynchronousconsultationinboxscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1028AsynchronousconsultationinboxscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1028AsynchronousconsultationinboxscreenScreen", "/generated/asynchronous-consultation-inbox");
    }
}

