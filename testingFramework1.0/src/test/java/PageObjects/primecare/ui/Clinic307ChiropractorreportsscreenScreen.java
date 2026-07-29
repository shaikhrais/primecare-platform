package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic307ChiropractorreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 307;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorreports-screen')]")
	private WebElement chiropractorreportsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorreports-title')]")
	private WebElement chiropractorreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorreports-content')]")
	private WebElement chiropractorreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorreports-btn-3')]")
	private WebElement chiropractorreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorreports-btn-2')]")
	private WebElement chiropractorreportsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorreports-btn-1')]")
	private WebElement chiropractorreportsBtn1;

    public Clinic307ChiropractorreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic307ChiropractorreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic307ChiropractorreportsscreenScreen", "/offices/clinical/roles/chiropractor/reports");
    }
}

