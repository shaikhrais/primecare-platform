package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic848SecurityhubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 848;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_hub-content')]")
	private WebElement primaryContent;

    public Clinic848SecurityhubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic848SecurityhubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic848SecurityhubscreenScreen", "/governance/device-security");
    }
}

