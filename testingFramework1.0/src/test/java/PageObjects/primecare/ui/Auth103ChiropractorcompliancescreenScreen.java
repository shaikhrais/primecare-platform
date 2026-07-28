package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth103ChiropractorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 103;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcompliance-screen')]")
	private WebElement chiropractorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcompliance-content')]")
	private WebElement chiropractorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcompliance-title')]")
	private WebElement chiropractorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcompliance-btn-2')]")
	private WebElement chiropractorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcompliance-btn-3')]")
	private WebElement chiropractorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcompliance-btn-1')]")
	private WebElement chiropractorcomplianceBtn1;

    public Auth103ChiropractorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth103ChiropractorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth103ChiropractorcompliancescreenScreen", "/offices/clinical/roles/chiropractor/compliance");
    }
}

