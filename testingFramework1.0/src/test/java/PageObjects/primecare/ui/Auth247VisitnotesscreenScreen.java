package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth247VisitnotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 247;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_visit_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_visit_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_visit_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-screen')]")
	private WebElement pswvisitnotesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-title')]")
	private WebElement pswvisitnotesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-loading')]")
	private WebElement pswvisitnotesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-btn-3')]")
	private WebElement pswvisitnotesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-btn-1')]")
	private WebElement pswvisitnotesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-content')]")
	private WebElement pswvisitnotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-btn-2')]")
	private WebElement pswvisitnotesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswvisitnotes-btn-4')]")
	private WebElement pswvisitnotesBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'visit-notes-textarea')]")
	private WebElement visitNotesTextarea;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'save-button')]")
	private WebElement saveButton;

    public Auth247VisitnotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth247VisitnotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth247VisitnotesscreenScreen", "/offices/clinical/roles/psw/visit-notes");
    }
}

