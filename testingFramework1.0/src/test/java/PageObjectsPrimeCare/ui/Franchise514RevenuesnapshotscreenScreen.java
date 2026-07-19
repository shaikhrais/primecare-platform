package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise514RevenuesnapshotscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 514;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue_snapshot-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue_snapshot-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue_snapshot-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-loading')]")
	private WebElement revenuesnapshotLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-btn-3')]")
	private WebElement revenuesnapshotBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-btn-2')]")
	private WebElement revenuesnapshotBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-content')]")
	private WebElement revenuesnapshotContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-title')]")
	private WebElement revenuesnapshotTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-screen')]")
	private WebElement revenuesnapshotScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenuesnapshot-btn-1')]")
	private WebElement revenuesnapshotBtn1;

    public Franchise514RevenuesnapshotscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise514RevenuesnapshotscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise514RevenuesnapshotscreenScreen", "/executive/revenue-snapshot");
    }
}
