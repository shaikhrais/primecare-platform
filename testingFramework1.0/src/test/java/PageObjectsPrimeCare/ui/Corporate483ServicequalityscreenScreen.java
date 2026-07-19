package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate483ServicequalityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 483;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_quality-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_quality-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_quality-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-loading')]")
	private WebElement servicequalityLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-content')]")
	private WebElement servicequalityContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-screen')]")
	private WebElement servicequalityScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-btn-1')]")
	private WebElement servicequalityBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-btn-2')]")
	private WebElement servicequalityBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-btn-3')]")
	private WebElement servicequalityBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'servicequality-title')]")
	private WebElement servicequalityTitle;

    public Corporate483ServicequalityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate483ServicequalityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate483ServicequalityscreenScreen", "/executive/service-quality");
    }
}
