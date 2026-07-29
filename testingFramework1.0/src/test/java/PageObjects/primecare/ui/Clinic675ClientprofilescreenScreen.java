package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic675ClientprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 675;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprofilescreen-screen')]")
	private WebElement clientprofilescreenScreen;

    public Clinic675ClientprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic675ClientprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic675ClientprofilescreenScreen", "/clinic/client-profile");
    }
}

