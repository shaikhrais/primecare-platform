package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic719CeoleadershipreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 719;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_leadership_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_leadership_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_leadership_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceoleadershipreportsscreen-screen')]")
	private WebElement ceoleadershipreportsscreenScreen;

    public Clinic719CeoleadershipreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic719CeoleadershipreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic719CeoleadershipreportsscreenScreen", "/offices/corporate/roles/ceo/leadership-reports");
    }
}

