package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic375RnincidentreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 375;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_incident_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_incident_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_incident_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-btn-3')]")
	private WebElement rnincidentreviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-btn-1')]")
	private WebElement rnincidentreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-loading')]")
	private WebElement rnincidentreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-btn-2')]")
	private WebElement rnincidentreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-title')]")
	private WebElement rnincidentreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-screen')]")
	private WebElement rnincidentreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnincidentreview-content')]")
	private WebElement rnincidentreviewContent;

    public Clinic375RnincidentreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic375RnincidentreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic375RnincidentreviewscreenScreen", "/offices/clinical/roles/rn/rn-incident-review");
    }
}
