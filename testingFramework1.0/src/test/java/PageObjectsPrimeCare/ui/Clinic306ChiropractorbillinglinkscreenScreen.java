package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic306ChiropractorbillinglinkscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 306;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_billing_link-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_billing_link-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_billing_link-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorbillinglink-btn-1')]")
	private WebElement chiropractorbillinglinkBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorbillinglink-title')]")
	private WebElement chiropractorbillinglinkTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorbillinglink-btn-3')]")
	private WebElement chiropractorbillinglinkBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorbillinglink-screen')]")
	private WebElement chiropractorbillinglinkScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorbillinglink-btn-2')]")
	private WebElement chiropractorbillinglinkBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorbillinglink-content')]")
	private WebElement chiropractorbillinglinkContent;

    public Clinic306ChiropractorbillinglinkscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic306ChiropractorbillinglinkscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic306ChiropractorbillinglinkscreenScreen", "/offices/clinical/roles/chiropractor/billing-link");
    }
}
