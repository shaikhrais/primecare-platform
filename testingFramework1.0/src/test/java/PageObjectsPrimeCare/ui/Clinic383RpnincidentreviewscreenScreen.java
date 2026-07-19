package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic383RpnincidentreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 383;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_incident_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_incident_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_incident_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-loading')]")
	private WebElement rpnincidentreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-screen')]")
	private WebElement rpnincidentreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-btn-2')]")
	private WebElement rpnincidentreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-btn-1')]")
	private WebElement rpnincidentreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-btn-3')]")
	private WebElement rpnincidentreviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-content')]")
	private WebElement rpnincidentreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnincidentreview-title')]")
	private WebElement rpnincidentreviewTitle;

    public Clinic383RpnincidentreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic383RpnincidentreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic383RpnincidentreviewscreenScreen", "/offices/clinical/roles/rpn/rpn-incident-review");
    }
}
