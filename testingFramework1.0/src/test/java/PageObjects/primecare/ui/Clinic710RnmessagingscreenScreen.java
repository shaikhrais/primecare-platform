package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic710RnmessagingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 710;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_messaging-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_messaging-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_messaging-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnmessagingscreen-screen')]")
	private WebElement rnmessagingscreenScreen;

    public Clinic710RnmessagingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic710RnmessagingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic710RnmessagingscreenScreen", "/generated/rn-messaging");
    }
}

