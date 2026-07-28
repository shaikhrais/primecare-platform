package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth92HswadlloggerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 92;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_adl_logger-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_adl_logger-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_adl_logger-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-adl-checklist-form')]")
	private WebElement dataCyHswAdlChecklistForm;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-meals-assistance-logger')]")
	private WebElement dataCyHswMealsAssistanceLogger;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-hygiene-support-checkboxes')]")
	private WebElement dataCyHswHygieneSupportCheckboxes;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswadllogger-btn-1')]")
	private WebElement hswadlloggerBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'save_adl_draft')]")
	private WebElement saveAdlDraft;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswadllogger-title')]")
	private WebElement hswadlloggerTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'submit_adl_logs')]")
	private WebElement submitAdlLogs;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswadllogger-screen')]")
	private WebElement hswadlloggerScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswadllogger-content')]")
	private WebElement hswadlloggerContent;

    public Auth92HswadlloggerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth92HswadlloggerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth92HswadlloggerscreenScreen", "/clinical/hsw-adl-logger");
    }
}

