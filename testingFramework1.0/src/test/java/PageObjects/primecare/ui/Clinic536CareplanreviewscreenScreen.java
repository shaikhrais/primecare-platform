package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic536CareplanreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 536;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_plan_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_plan_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_plan_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-btn-1')]")
	private WebElement careplanreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-title')]")
	private WebElement careplanreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-screen')]")
	private WebElement careplanreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-btn-2')]")
	private WebElement careplanreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-content')]")
	private WebElement careplanreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-loading')]")
	private WebElement careplanreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careplanreview-btn-3')]")
	private WebElement careplanreviewBtn3;

    public Clinic536CareplanreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic536CareplanreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic536CareplanreviewscreenScreen", "/offices/clinical/roles/rn/care-plan-review");
    }
}

