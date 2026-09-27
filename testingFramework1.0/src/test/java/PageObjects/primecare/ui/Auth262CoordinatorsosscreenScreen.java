package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth262CoordinatorsosscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 262;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_sos-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_sos-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_sos-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-2')]")
	private WebElement coordinatorsosBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-9')]")
	private WebElement coordinatorsosBtn9;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-content')]")
	private WebElement coordinatorsosContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-4')]")
	private WebElement coordinatorsosBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_sos_screen_textfield_input_1')]")
	private WebElement coordinatorSosScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-6')]")
	private WebElement coordinatorsosBtn6;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-13')]")
	private WebElement coordinatorsosBtn13;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-10')]")
	private WebElement coordinatorsosBtn10;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-screen')]")
	private WebElement coordinatorsosScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-7')]")
	private WebElement coordinatorsosBtn7;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-title')]")
	private WebElement coordinatorsosTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-12')]")
	private WebElement coordinatorsosBtn12;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-3')]")
	private WebElement coordinatorsosBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-5')]")
	private WebElement coordinatorsosBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-11')]")
	private WebElement coordinatorsosBtn11;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-loading')]")
	private WebElement coordinatorsosLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-8')]")
	private WebElement coordinatorsosBtn8;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorsos-btn-1')]")
	private WebElement coordinatorsosBtn1;

    public Auth262CoordinatorsosscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth262CoordinatorsosscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth262CoordinatorsosscreenScreen", "/staff/coordinator-sos");
    }
}

