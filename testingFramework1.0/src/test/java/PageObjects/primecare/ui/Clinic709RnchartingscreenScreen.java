package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic709RnchartingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 709;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_charting-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_charting-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_charting-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncharting-content')]")
	private WebElement rnchartingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn-charting-btn-submit-feedback')]")
	private WebElement rnChartingBtnSubmitFeedback;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn-charting-btn-refresh')]")
	private WebElement rnChartingBtnRefresh;

    public Clinic709RnchartingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic709RnchartingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic709RnchartingscreenScreen", "/generated/rn-charting");
    }
}

