package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic349PhysiotherapisttreatmentnotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 349;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_treatment_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_treatment_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_treatment_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapisttreatmentnotes-content')]")
	private WebElement physiotherapisttreatmentnotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapisttreatmentnotes-title')]")
	private WebElement physiotherapisttreatmentnotesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapisttreatmentnotes-screen')]")
	private WebElement physiotherapisttreatmentnotesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapisttreatmentnotes-btn-3')]")
	private WebElement physiotherapisttreatmentnotesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapisttreatmentnotes-btn-1')]")
	private WebElement physiotherapisttreatmentnotesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapisttreatmentnotes-btn-2')]")
	private WebElement physiotherapisttreatmentnotesBtn2;

    public Clinic349PhysiotherapisttreatmentnotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic349PhysiotherapisttreatmentnotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic349PhysiotherapisttreatmentnotesscreenScreen", "/offices/clinical/roles/physiotherapist/treatment-notes");
    }
}
