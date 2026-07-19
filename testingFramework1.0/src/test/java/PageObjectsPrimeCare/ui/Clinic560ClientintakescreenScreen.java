package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic560ClientintakescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 560;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_intake-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_intake-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_intake-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-btn-1')]")
	private WebElement clientintakeBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-screen')]")
	private WebElement clientintakeScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-content')]")
	private WebElement clientintakeContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-btn-3')]")
	private WebElement clientintakeBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-title')]")
	private WebElement clientintakeTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-loading')]")
	private WebElement clientintakeLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientintake-btn-2')]")
	private WebElement clientintakeBtn2;

    public Clinic560ClientintakescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic560ClientintakescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic560ClientintakescreenScreen", "/offices/clinical/roles/intake_coordinator/client-intake");
    }
}
