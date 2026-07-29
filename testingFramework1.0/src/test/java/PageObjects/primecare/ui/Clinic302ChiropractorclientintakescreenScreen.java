package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic302ChiropractorclientintakescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 302;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_client_intake-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_client_intake-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_client_intake-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorclientintake-content')]")
	private WebElement chiropractorclientintakeContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorclientintake-btn-2')]")
	private WebElement chiropractorclientintakeBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorclientintake-btn-3')]")
	private WebElement chiropractorclientintakeBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorclientintake-screen')]")
	private WebElement chiropractorclientintakeScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorclientintake-title')]")
	private WebElement chiropractorclientintakeTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorclientintake-btn-1')]")
	private WebElement chiropractorclientintakeBtn1;

    public Clinic302ChiropractorclientintakescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic302ChiropractorclientintakescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic302ChiropractorclientintakescreenScreen", "/offices/clinical/roles/chiropractor/client-intake");
    }
}

