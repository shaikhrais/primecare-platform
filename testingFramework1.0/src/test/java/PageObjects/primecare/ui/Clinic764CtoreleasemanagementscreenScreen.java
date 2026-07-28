package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic764CtoreleasemanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 764;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_release_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_release_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_release_management-content')]")
	private WebElement primaryContent;

    public Clinic764CtoreleasemanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic764CtoreleasemanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic764CtoreleasemanagementscreenScreen", "/offices/corporate/roles/cto/release-management");
    }
}

