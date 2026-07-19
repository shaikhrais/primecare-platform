package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic787CourselibraryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 787;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_library-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_library-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_library-content')]")
	private WebElement primaryContent;

    public Clinic787CourselibraryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic787CourselibraryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic787CourselibraryscreenScreen", "/generated/course-library");
    }
}
