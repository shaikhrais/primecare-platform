package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate479FranchiseoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 479;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-btn-3')]")
	private WebElement franchiseoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-loading')]")
	private WebElement franchiseoverviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-content')]")
	private WebElement franchiseoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-title')]")
	private WebElement franchiseoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-btn-2')]")
	private WebElement franchiseoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-btn-1')]")
	private WebElement franchiseoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseoverview-screen')]")
	private WebElement franchiseoverviewScreen;

    public Corporate479FranchiseoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate479FranchiseoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate479FranchiseoverviewscreenScreen", "/executive/franchise-overview");
    }
}
