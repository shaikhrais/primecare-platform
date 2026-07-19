package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client557XrayreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 557;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xray_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xray_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xray_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-content')]")
	private WebElement xrayreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-btn-1')]")
	private WebElement xrayreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-btn-2')]")
	private WebElement xrayreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-title')]")
	private WebElement xrayreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-loading')]")
	private WebElement xrayreviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-screen')]")
	private WebElement xrayreviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'xrayreview-btn-3')]")
	private WebElement xrayreviewBtn3;

    public Client557XrayreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client557XrayreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client557XrayreviewscreenScreen", "/offices/clinical/roles/chiropractor/xray-review");
    }
}
