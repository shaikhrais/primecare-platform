package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth250RnassessmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 250;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_assessments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_assessments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_assessments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnassessments-screen')]")
	private WebElement rnassessmentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnassessments-content')]")
	private WebElement rnassessmentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnassessments-loading')]")
	private WebElement rnassessmentsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnassessments-btn-1')]")
	private WebElement rnassessmentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnassessments-btn-2')]")
	private WebElement rnassessmentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnassessments-title-appbar')]")
	private WebElement rnassessmentsTitleAppbar;

    public Auth250RnassessmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth250RnassessmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth250RnassessmentsscreenScreen", "/offices/clinical/roles/rn/rn-assessments");
    }
}
