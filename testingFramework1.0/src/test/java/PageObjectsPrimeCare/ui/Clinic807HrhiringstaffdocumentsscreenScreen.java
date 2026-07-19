package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic807HrhiringstaffdocumentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 807;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_staff_documents-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_staff_documents-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_staff_documents-content')]")
	private WebElement primaryContent;

    public Clinic807HrhiringstaffdocumentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic807HrhiringstaffdocumentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic807HrhiringstaffdocumentsscreenScreen", "/offices/franchise/roles/hr_hiring/staff-documents");
    }
}
