package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client289CaregiverclientprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 289;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_client_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_client_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_client_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverclientprofile-btn-1')]")
	private WebElement caregiverclientprofileBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverclientprofile-screen')]")
	private WebElement caregiverclientprofileScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverclientprofile-btn-2')]")
	private WebElement caregiverclientprofileBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverclientprofile-title')]")
	private WebElement caregiverclientprofileTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverclientprofile-btn-3')]")
	private WebElement caregiverclientprofileBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverclientprofile-content')]")
	private WebElement caregiverclientprofileContent;

    public Client289CaregiverclientprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client289CaregiverclientprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client289CaregiverclientprofilescreenScreen", "/offices/clinical/roles/caregiver/client-profile");
    }
}

