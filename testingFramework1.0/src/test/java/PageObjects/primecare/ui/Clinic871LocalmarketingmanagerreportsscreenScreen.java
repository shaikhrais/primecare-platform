package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic871LocalmarketingmanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 871;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic871LocalmarketingmanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic871LocalmarketingmanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic871LocalmarketingmanagerreportsscreenScreen", "/generated/local-marketing-manager-reports");
    }
}

