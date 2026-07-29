package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic705PswdailynotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 705;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_daily_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_daily_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_daily_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_daily_notes-cancel')]")
	private WebElement pswDailyNotesCancel;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_daily_notes-save')]")
	private WebElement pswDailyNotesSave;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdailynotes-content')]")
	private WebElement pswdailynotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_daily_notes-add_note')]")
	private WebElement pswDailyNotesAddNote;

    public Clinic705PswdailynotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic705PswdailynotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic705PswdailynotesscreenScreen", "/generated/psw-daily-notes");
    }
}

