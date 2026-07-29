package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic840LeadershipreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 840;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadership_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadership_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadership_reports-content')]")
	private WebElement primaryContent;

    public Clinic840LeadershipreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic840LeadershipreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic840LeadershipreportsscreenScreen", "/generated/offices/corporate/roles/ceo/leadership-reports");
    }
}

