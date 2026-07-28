package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth260CoordinatordispatchmapscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 260;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_dispatch_map-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_dispatch_map-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_dispatch_map-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-screen')]")
	private WebElement coordinatordispatchmapScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-loading')]")
	private WebElement coordinatordispatchmapLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-6')]")
	private WebElement coordinatordispatchmapBtn6;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-2')]")
	private WebElement coordinatordispatchmapBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-1')]")
	private WebElement coordinatordispatchmapBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-title')]")
	private WebElement coordinatordispatchmapTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-3')]")
	private WebElement coordinatordispatchmapBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-7')]")
	private WebElement coordinatordispatchmapBtn7;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-4')]")
	private WebElement coordinatordispatchmapBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-content')]")
	private WebElement coordinatordispatchmapContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatordispatchmap-btn-5')]")
	private WebElement coordinatordispatchmapBtn5;

    public Auth260CoordinatordispatchmapscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth260CoordinatordispatchmapscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth260CoordinatordispatchmapscreenScreen", "/staff/coordinator-dispatch-map");
    }
}

