package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic366RmttreatmentnotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 366;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_treatment_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_treatment_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_treatment_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-btn-3')]")
	private WebElement rmttreatmentnotesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-screen')]")
	private WebElement rmttreatmentnotesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-title')]")
	private WebElement rmttreatmentnotesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-content')]")
	private WebElement rmttreatmentnotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-btn-2')]")
	private WebElement rmttreatmentnotesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-btn-1')]")
	private WebElement rmttreatmentnotesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmttreatmentnotes-loading')]")
	private WebElement rmttreatmentnotesLoading;

    public Clinic366RmttreatmentnotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic366RmttreatmentnotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic366RmttreatmentnotesscreenScreen", "/offices/clinical/roles/rmt/treatment-notes");
    }
}
