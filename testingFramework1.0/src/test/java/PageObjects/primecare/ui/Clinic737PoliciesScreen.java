package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic737PoliciesScreen extends baseTest {
 
    public static final int SCREEN_ID = 737;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policies-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policies-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policies-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policiesscreen-screen')]")
	private WebElement policiesscreenScreen;

    public Clinic737PoliciesScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic737PoliciesScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic737PoliciesScreen", "/offices/corporate/roles/compliance_manager/policies");
    }
}

