package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1006PharmacydispensingdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1006;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pharmacy_dispensing_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pharmacy_dispensing_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pharmacy_dispensing_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic1006PharmacydispensingdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1006PharmacydispensingdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1006PharmacydispensingdashboardscreenScreen", "/generated/pharmacy-dispensing-dashboard");
    }
}

