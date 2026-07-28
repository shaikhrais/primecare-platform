package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic912AccessreviewcertifierscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 912;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'access_review_certifier-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'access_review_certifier-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'access_review_certifier-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'access_review_certifier_iconbutton_button_1')]")
	private WebElement accessReviewCertifierIconbuttonButton1;

    public Clinic912AccessreviewcertifierscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic912AccessreviewcertifierscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic912AccessreviewcertifierscreenScreen", "/generated/access-review-certifier");
    }
}

