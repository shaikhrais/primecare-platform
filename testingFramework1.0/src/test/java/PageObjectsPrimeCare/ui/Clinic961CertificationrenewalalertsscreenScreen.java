package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic961CertificationrenewalalertsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 961;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_renewal_alerts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_renewal_alerts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_renewal_alerts-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_renewal_alerts_iconbutton_button_1')]")
	private WebElement certificationRenewalAlertsIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'certification_renewal_alerts_elevatedbutton_button_1')]")
	private WebElement certificationRenewalAlertsElevatedbuttonButton1;

    public Clinic961CertificationrenewalalertsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic961CertificationrenewalalertsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic961CertificationrenewalalertsscreenScreen", "/generated/certification-renewal-alerts");
    }
}
