package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth176CxdirectorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 176;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-btn-3')]")
	private WebElement cxdirectorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-content')]")
	private WebElement cxdirectorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-btn-4')]")
	private WebElement cxdirectorcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-btn-2')]")
	private WebElement cxdirectorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-screen')]")
	private WebElement cxdirectorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-title')]")
	private WebElement cxdirectorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-btn-1')]")
	private WebElement cxdirectorcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorcompliance-btn-5')]")
	private WebElement cxdirectorcomplianceBtn5;

    public Auth176CxdirectorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth176CxdirectorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth176CxdirectorcompliancescreenScreen", "/executive/cx-director-compliance");
    }
}

