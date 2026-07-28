package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic756CtoaccesscontrolscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 756;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_access_control-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_access_control-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_access_control-content')]")
	private WebElement primaryContent;

    public Clinic756CtoaccesscontrolscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic756CtoaccesscontrolscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic756CtoaccesscontrolscreenScreen", "/offices/corporate/roles/cto/access-control");
    }
}

