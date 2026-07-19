package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic374RncareplanreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 374;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plan_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plan_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plan_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-btn-1')]")
	private WebElement rncareplanreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-content')]")
	private WebElement rncareplanreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-btn-3')]")
	private WebElement rncareplanreviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-title')]")
	private WebElement rncareplanreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-loading')]")
	private WebElement rncareplanreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-btn-2')]")
	private WebElement rncareplanreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplanreview-screen')]")
	private WebElement rncareplanreviewScreen;

    public Clinic374RncareplanreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic374RncareplanreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic374RncareplanreviewscreenScreen", "/offices/clinical/roles/rn/rn-care-plan-review");
    }
}
