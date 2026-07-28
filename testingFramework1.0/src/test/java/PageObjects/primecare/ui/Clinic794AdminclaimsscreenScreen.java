package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic794AdminclaimsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 794;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_claims-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_claims-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_claims-content')]")
	private WebElement primaryContent;

    public Clinic794AdminclaimsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic794AdminclaimsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic794AdminclaimsscreenScreen", "/offices/franchise/roles/admin/claims");
    }
}

