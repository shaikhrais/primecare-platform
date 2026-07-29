package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth93HswcareplansscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 93;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_care_plans-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_care_plans-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_care_plans-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswcareplans-content')]")
	private WebElement hswcareplansContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sign_off_care_plan_review')]")
	private WebElement signOffCarePlanReview;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-mobility-aids-panel')]")
	private WebElement dataCyHswMobilityAidsPanel;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswcareplans-screen')]")
	private WebElement hswcareplansScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswcareplans-btn-1')]")
	private WebElement hswcareplansBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswcareplans-title')]")
	private WebElement hswcareplansTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-dietary-guidelines-viewer')]")
	private WebElement dataCyHswDietaryGuidelinesViewer;

    public Auth93HswcareplansscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth93HswcareplansscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth93HswcareplansscreenScreen", "/clinical/hsw-care-plans");
    }
}

