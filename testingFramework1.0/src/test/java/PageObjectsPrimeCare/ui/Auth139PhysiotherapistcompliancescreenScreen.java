package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth139PhysiotherapistcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 139;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcompliance-title')]")
	private WebElement physiotherapistcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcompliance-content')]")
	private WebElement physiotherapistcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcompliance-btn-1')]")
	private WebElement physiotherapistcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcompliance-btn-3')]")
	private WebElement physiotherapistcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcompliance-btn-2')]")
	private WebElement physiotherapistcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcompliance-screen')]")
	private WebElement physiotherapistcomplianceScreen;

    public Auth139PhysiotherapistcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth139PhysiotherapistcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth139PhysiotherapistcompliancescreenScreen", "/offices/clinical/roles/physiotherapist/compliance");
    }
}
