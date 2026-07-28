package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic907ItadministratordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 907;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'it_administrator_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'it_administrator_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'it_administrator_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic907ItadministratordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic907ItadministratordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic907ItadministratordashboardscreenScreen", "/generated/it-administrator-dashboard");
    }
}

