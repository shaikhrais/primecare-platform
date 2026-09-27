package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic801AdminreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 801;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_reports-content')]")
	private WebElement primaryContent;

    public Clinic801AdminreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic801AdminreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic801AdminreportsscreenScreen", "/offices/franchise/roles/admin/reports");
    }
}

