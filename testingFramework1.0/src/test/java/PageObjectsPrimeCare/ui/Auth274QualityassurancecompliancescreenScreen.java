package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth274QualityassurancecompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 274;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-btn-4')]")
	private WebElement qualityassurancecomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-btn-1')]")
	private WebElement qualityassurancecomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-btn-2')]")
	private WebElement qualityassurancecomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-content')]")
	private WebElement qualityassurancecomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-screen')]")
	private WebElement qualityassurancecomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-btn-3')]")
	private WebElement qualityassurancecomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-title')]")
	private WebElement qualityassurancecomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancecompliance-btn-5')]")
	private WebElement qualityassurancecomplianceBtn5;

    public Auth274QualityassurancecompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth274QualityassurancecompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth274QualityassurancecompliancescreenScreen", "/staff/quality-assurance-compliance");
    }
}
