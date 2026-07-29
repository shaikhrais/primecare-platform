package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic946VendorriskassessorscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 946;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vendor_risk_assessor-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vendor_risk_assessor-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vendor_risk_assessor-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vendor_risk_assessor_iconbutton_button_1')]")
	private WebElement vendorRiskAssessorIconbuttonButton1;

    public Clinic946VendorriskassessorscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic946VendorriskassessorscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic946VendorriskassessorscreenScreen", "/generated/vendor-risk-assessor");
    }
}

