package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic999ControlledsubstancelogscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 999;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'controlled_substance_log-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'controlled_substance_log-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'controlled_substance_log-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance-btn-add')]")
	private WebElement substanceBtnAdd;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance-btn-sign')]")
	private WebElement substanceBtnSign;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance-search')]")
	private WebElement substanceSearch;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance-witness-field')]")
	private WebElement substanceWitnessField;

    public Clinic999ControlledsubstancelogscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic999ControlledsubstancelogscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic999ControlledsubstancelogscreenScreen", "/generated/controlled-substance-log");
    }
}

