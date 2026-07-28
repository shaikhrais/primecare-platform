package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1027TrialdatacollectioncrfscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1027;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trial_data_collection_c_r_f-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trial_data_collection_c_r_f-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trial_data_collection_c_r_f-content')]")
	private WebElement primaryContent;

    public Clinic1027TrialdatacollectioncrfscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1027TrialdatacollectioncrfscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1027TrialdatacollectioncrfscreenScreen", "/generated/trial-data-collection-c-r-f");
    }
}

