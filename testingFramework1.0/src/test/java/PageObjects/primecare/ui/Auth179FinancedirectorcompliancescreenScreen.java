package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth179FinancedirectorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 179;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-title')]")
	private WebElement financedirectorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-btn-2')]")
	private WebElement financedirectorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-screen')]")
	private WebElement financedirectorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-btn-3')]")
	private WebElement financedirectorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-content')]")
	private WebElement financedirectorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-btn-4')]")
	private WebElement financedirectorcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-btn-5')]")
	private WebElement financedirectorcomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectorcompliance-btn-1')]")
	private WebElement financedirectorcomplianceBtn1;

    public Auth179FinancedirectorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth179FinancedirectorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth179FinancedirectorcompliancescreenScreen", "/executive/finance-director-compliance");
    }
}

