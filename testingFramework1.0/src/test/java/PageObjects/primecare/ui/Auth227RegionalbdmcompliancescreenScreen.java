package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth227RegionalbdmcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 227;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmcompliance-btn-3')]")
	private WebElement regionalbdmcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmcompliance-title')]")
	private WebElement regionalbdmcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmcompliance-btn-1')]")
	private WebElement regionalbdmcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmcompliance-screen')]")
	private WebElement regionalbdmcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmcompliance-btn-2')]")
	private WebElement regionalbdmcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmcompliance-content')]")
	private WebElement regionalbdmcomplianceContent;

    public Auth227RegionalbdmcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth227RegionalbdmcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth227RegionalbdmcompliancescreenScreen", "/management/regional-bdm-compliance");
    }
}

