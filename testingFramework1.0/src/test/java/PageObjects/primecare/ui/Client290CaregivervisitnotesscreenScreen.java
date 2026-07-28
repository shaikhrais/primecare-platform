package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client290CaregivervisitnotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 290;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_visit_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_visit_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_visit_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivervisitnotes-btn-3')]")
	private WebElement caregivervisitnotesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivervisitnotes-btn-1')]")
	private WebElement caregivervisitnotesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivervisitnotes-btn-2')]")
	private WebElement caregivervisitnotesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivervisitnotes-title')]")
	private WebElement caregivervisitnotesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivervisitnotes-content')]")
	private WebElement caregivervisitnotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregivervisitnotes-screen')]")
	private WebElement caregivervisitnotesScreen;

    public Client290CaregivervisitnotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client290CaregivervisitnotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client290CaregivervisitnotesscreenScreen", "/offices/clinical/roles/caregiver/visit-notes");
    }
}

