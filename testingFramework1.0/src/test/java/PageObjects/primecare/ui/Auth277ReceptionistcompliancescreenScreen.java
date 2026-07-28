package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth277ReceptionistcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 277;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-title')]")
	private WebElement receptionistcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-btn-1')]")
	private WebElement receptionistcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-btn-5')]")
	private WebElement receptionistcomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-content')]")
	private WebElement receptionistcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-btn-3')]")
	private WebElement receptionistcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-screen')]")
	private WebElement receptionistcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-btn-4')]")
	private WebElement receptionistcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistcompliance-btn-2')]")
	private WebElement receptionistcomplianceBtn2;

    public Auth277ReceptionistcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth277ReceptionistcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth277ReceptionistcompliancescreenScreen", "/staff/receptionist-compliance");
    }
}

