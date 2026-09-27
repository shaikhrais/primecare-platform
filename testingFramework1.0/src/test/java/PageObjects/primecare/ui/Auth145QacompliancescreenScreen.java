package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth145QacompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 145;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-loading')]")
	private WebElement qacomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-btn-2')]")
	private WebElement qacomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-title')]")
	private WebElement qacomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-btn-1')]")
	private WebElement qacomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-content')]")
	private WebElement qacomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-btn-3')]")
	private WebElement qacomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qacompliance-screen')]")
	private WebElement qacomplianceScreen;

    public Auth145QacompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth145QacompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth145QacompliancescreenScreen", "/common/qa-compliance");
    }
}

