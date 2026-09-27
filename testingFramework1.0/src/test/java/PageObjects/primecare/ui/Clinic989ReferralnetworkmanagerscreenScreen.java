package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic989ReferralnetworkmanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 989;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_network_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_network_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_network_manager-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_network_manager_iconbutton_button_1')]")
	private WebElement referralNetworkManagerIconbuttonButton1;

    public Clinic989ReferralnetworkmanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic989ReferralnetworkmanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic989ReferralnetworkmanagerscreenScreen", "/generated/referral-network-manager");
    }
}

