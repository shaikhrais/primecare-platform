package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth182HrdirectorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 182;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcompliance-screen')]")
	private WebElement hrdirectorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcompliance-title')]")
	private WebElement hrdirectorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcompliance-btn-1')]")
	private WebElement hrdirectorcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcompliance-btn-3')]")
	private WebElement hrdirectorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcompliance-content')]")
	private WebElement hrdirectorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcompliance-btn-2')]")
	private WebElement hrdirectorcomplianceBtn2;

    public Auth182HrdirectorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth182HrdirectorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth182HrdirectorcompliancescreenScreen", "/executive/hr-director-compliance");
    }
}
