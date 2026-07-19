package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic844CompliancereviewsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 844;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_reviews-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_reviews-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_reviews-content')]")
	private WebElement primaryContent;

    public Clinic844CompliancereviewsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic844CompliancereviewsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic844CompliancereviewsscreenScreen", "/generated/compliance-reviews");
    }
}
