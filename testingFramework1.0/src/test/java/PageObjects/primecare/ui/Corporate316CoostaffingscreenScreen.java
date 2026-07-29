package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate316CoostaffingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 316;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_staffing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_staffing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_staffing-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-content')]")
	private WebElement coostaffingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-btn-1')]")
	private WebElement coostaffingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-btn-2')]")
	private WebElement coostaffingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-title')]")
	private WebElement coostaffingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-loading')]")
	private WebElement coostaffingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-btn-3')]")
	private WebElement coostaffingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coostaffing-screen')]")
	private WebElement coostaffingScreen;

    public Corporate316CoostaffingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate316CoostaffingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate316CoostaffingscreenScreen", "/executive/coo-staffing");
    }
}

