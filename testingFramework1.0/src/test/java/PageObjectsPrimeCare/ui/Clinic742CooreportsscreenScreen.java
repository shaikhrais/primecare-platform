package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic742CooreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 742;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_reports-content')]")
	private WebElement primaryContent;

    public Clinic742CooreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic742CooreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic742CooreportsscreenScreen", "/offices/corporate/roles/coo/reports");
    }
}
