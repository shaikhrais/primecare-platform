package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic698PswpatientprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 698;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_patient_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_patient_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_patient_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswpatientprofilescreen-screen')]")
	private WebElement pswpatientprofilescreenScreen;

    public Clinic698PswpatientprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic698PswpatientprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic698PswpatientprofilescreenScreen", "/generated/psw-patient-profile");
    }
}
