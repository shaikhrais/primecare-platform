package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic351PhysiotherapistbillinglinkscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 351;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_billing_link-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_billing_link-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_billing_link-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistbillinglink-btn-2')]")
	private WebElement physiotherapistbillinglinkBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistbillinglink-btn-3')]")
	private WebElement physiotherapistbillinglinkBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistbillinglink-content')]")
	private WebElement physiotherapistbillinglinkContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistbillinglink-title')]")
	private WebElement physiotherapistbillinglinkTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistbillinglink-btn-1')]")
	private WebElement physiotherapistbillinglinkBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistbillinglink-screen')]")
	private WebElement physiotherapistbillinglinkScreen;

    public Clinic351PhysiotherapistbillinglinkscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic351PhysiotherapistbillinglinkscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic351PhysiotherapistbillinglinkscreenScreen", "/offices/clinical/roles/physiotherapist/billing-link");
    }
}

