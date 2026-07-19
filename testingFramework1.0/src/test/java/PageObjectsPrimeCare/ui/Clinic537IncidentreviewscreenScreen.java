package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic537IncidentreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 537;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-btn-1')]")
	private WebElement incidentreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-screen')]")
	private WebElement incidentreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-loading')]")
	private WebElement incidentreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-title')]")
	private WebElement incidentreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-content')]")
	private WebElement incidentreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-btn-2')]")
	private WebElement incidentreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentreview-btn-3')]")
	private WebElement incidentreviewBtn3;

    public Clinic537IncidentreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic537IncidentreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic537IncidentreviewscreenScreen", "/offices/clinical/roles/rn/incident-review");
    }
}
