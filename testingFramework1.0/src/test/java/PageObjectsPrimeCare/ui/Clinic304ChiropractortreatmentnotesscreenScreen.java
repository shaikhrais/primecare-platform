package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic304ChiropractortreatmentnotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 304;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_treatment_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_treatment_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_treatment_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractortreatmentnotes-content')]")
	private WebElement chiropractortreatmentnotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractortreatmentnotes-title')]")
	private WebElement chiropractortreatmentnotesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractortreatmentnotes-btn-1')]")
	private WebElement chiropractortreatmentnotesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractortreatmentnotes-btn-2')]")
	private WebElement chiropractortreatmentnotesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractortreatmentnotes-btn-3')]")
	private WebElement chiropractortreatmentnotesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractortreatmentnotes-screen')]")
	private WebElement chiropractortreatmentnotesScreen;

    public Clinic304ChiropractortreatmentnotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic304ChiropractortreatmentnotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic304ChiropractortreatmentnotesscreenScreen", "/offices/clinical/roles/chiropractor/treatment-notes");
    }
}
