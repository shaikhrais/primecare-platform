package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1008CommunityhealthneedsassessmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1008;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_health_needs_assessment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_health_needs_assessment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_health_needs_assessment-content')]")
	private WebElement primaryContent;

    public Clinic1008CommunityhealthneedsassessmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1008CommunityhealthneedsassessmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1008CommunityhealthneedsassessmentscreenScreen", "/generated/community-health-needs-assessment");
    }
}

