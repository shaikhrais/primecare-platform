package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1037VirtualwaitingroomscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1037;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_waiting_room-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_waiting_room-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_waiting_room-content')]")
	private WebElement primaryContent;

    public Clinic1037VirtualwaitingroomscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1037VirtualwaitingroomscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1037VirtualwaitingroomscreenScreen", "/generated/virtual-waiting-room");
    }
}
