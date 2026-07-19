package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1029ChroniccaremanagementtrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1029;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chronic_care_management_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chronic_care_management_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chronic_care_management_tracker-content')]")
	private WebElement primaryContent;

    public Clinic1029ChroniccaremanagementtrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1029ChroniccaremanagementtrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1029ChroniccaremanagementtrackerscreenScreen", "/generated/chronic-care-management-tracker");
    }
}
