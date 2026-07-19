package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic770ItadmindashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 770;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'it_admin_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'it_admin_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'it_admin_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic770ItadmindashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic770ItadmindashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic770ItadmindashboardscreenScreen", "/offices/corporate/roles/it_admin/dashboard");
    }
}
