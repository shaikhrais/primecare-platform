package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic382RpncareplanreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 382;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_care_plan_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_care_plan_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_care_plan_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-title')]")
	private WebElement rpncareplanreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-btn-2')]")
	private WebElement rpncareplanreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-content')]")
	private WebElement rpncareplanreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-loading')]")
	private WebElement rpncareplanreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-btn-3')]")
	private WebElement rpncareplanreviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-screen')]")
	private WebElement rpncareplanreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncareplanreview-btn-1')]")
	private WebElement rpncareplanreviewBtn1;

    public Clinic382RpncareplanreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic382RpncareplanreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic382RpncareplanreviewscreenScreen", "/offices/clinical/roles/rpn/rpn-care-plan-review");
    }
}
