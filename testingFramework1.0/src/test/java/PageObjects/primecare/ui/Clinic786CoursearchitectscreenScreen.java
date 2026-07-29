package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic786CoursearchitectscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 786;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect-content')]")
	private WebElement primaryContent;

    public Clinic786CoursearchitectscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic786CoursearchitectscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic786CoursearchitectscreenScreen", "/generated/course-architect");
    }
}

