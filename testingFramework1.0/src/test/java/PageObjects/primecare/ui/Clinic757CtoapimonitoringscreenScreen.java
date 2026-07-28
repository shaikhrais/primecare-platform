package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic757CtoapimonitoringscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 757;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_api_monitoring-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_api_monitoring-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_api_monitoring-content')]")
	private WebElement primaryContent;

    public Clinic757CtoapimonitoringscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic757CtoapimonitoringscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic757CtoapimonitoringscreenScreen", "/offices/corporate/roles/cto/api-monitoring");
    }
}

