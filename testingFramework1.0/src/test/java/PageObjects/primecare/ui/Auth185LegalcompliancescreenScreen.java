package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth185LegalcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 185;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-btn-1')]")
	private WebElement legalcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-loading')]")
	private WebElement legalcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-btn-2')]")
	private WebElement legalcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-btn-3')]")
	private WebElement legalcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-content')]")
	private WebElement legalcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-title')]")
	private WebElement legalcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalcompliance-screen')]")
	private WebElement legalcomplianceScreen;

    public Auth185LegalcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth185LegalcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth185LegalcompliancescreenScreen", "/executive/legal-compliance");
    }
}

