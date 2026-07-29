package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic836TicketcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 836;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticket_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticket_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticket_center-content')]")
	private WebElement primaryContent;

    public Clinic836TicketcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic836TicketcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic836TicketcenterscreenScreen", "/governance/tickets");
    }
}

