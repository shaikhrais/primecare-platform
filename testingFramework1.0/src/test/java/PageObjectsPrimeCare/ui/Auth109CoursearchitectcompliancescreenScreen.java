package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth109CoursearchitectcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 109;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectcompliance-screen')]")
	private WebElement coursearchitectcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectcompliance-title')]")
	private WebElement coursearchitectcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectcompliance-btn-1')]")
	private WebElement coursearchitectcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectcompliance-btn-2')]")
	private WebElement coursearchitectcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectcompliance-content')]")
	private WebElement coursearchitectcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectcompliance-btn-3')]")
	private WebElement coursearchitectcomplianceBtn3;

    public Auth109CoursearchitectcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth109CoursearchitectcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth109CoursearchitectcompliancescreenScreen", "/common/course-architect-compliance");
    }
}
