package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic629SuccessprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 629;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'success_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'success_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'success_profile-content')]")
	private WebElement primaryContent;

    public Clinic629SuccessprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic629SuccessprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic629SuccessprofilescreenScreen", "/generated/success-profile");
    }
}
