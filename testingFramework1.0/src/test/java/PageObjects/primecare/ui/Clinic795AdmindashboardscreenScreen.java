package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic795AdmindashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 795;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic795AdmindashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic795AdmindashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic795AdmindashboardscreenScreen", "/offices/franchise/roles/admin/dashboard");
    }
}

