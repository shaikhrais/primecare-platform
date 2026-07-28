package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic738RiskregisterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 738;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk_register-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk_register-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk_register-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk-register-btn-add')]")
	private WebElement riskRegisterBtnAdd;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk-register-btn-export')]")
	private WebElement riskRegisterBtnExport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk-register-search')]")
	private WebElement riskRegisterSearch;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskregister-content')]")
	private WebElement riskregisterContent;

    public Clinic738RiskregisterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic738RiskregisterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic738RiskregisterscreenScreen", "/offices/corporate/roles/compliance_manager/risk-register");
    }
}

