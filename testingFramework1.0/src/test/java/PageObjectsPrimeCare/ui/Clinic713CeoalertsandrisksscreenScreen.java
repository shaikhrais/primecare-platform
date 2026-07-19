package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic713CeoalertsandrisksscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 713;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_alerts_and_risks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_alerts_and_risks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_alerts_and_risks-content')]")
	private WebElement primaryContent;

    public Clinic713CeoalertsandrisksscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic713CeoalertsandrisksscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic713CeoalertsandrisksscreenScreen", "/offices/corporate/roles/ceo/alerts-and-risks");
    }
}
