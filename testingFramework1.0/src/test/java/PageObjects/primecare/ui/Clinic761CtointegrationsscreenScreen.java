package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic761CtointegrationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 761;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_integrations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_integrations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_integrations-content')]")
	private WebElement primaryContent;

    public Clinic761CtointegrationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic761CtointegrationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic761CtointegrationsscreenScreen", "/offices/corporate/roles/cto/integrations");
    }
}

