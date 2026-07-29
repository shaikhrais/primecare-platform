package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1032RemotediagnosticserscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1032;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'remote_diagnosticser-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'remote_diagnosticser-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'remote_diagnosticser-content')]")
	private WebElement primaryContent;

    public Clinic1032RemotediagnosticserscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1032RemotediagnosticserscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1032RemotediagnosticserscreenScreen", "/generated/remote-diagnosticser");
    }
}

