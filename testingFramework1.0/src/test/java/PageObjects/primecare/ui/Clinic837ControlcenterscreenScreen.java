package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic837ControlcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 837;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'control_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'control_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'control_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-btn-dispatch')]")
	private WebElement dataCyBtnDispatch;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-btn-upload-proof')]")
	private WebElement dataCyBtnUploadProof;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'control_center_screen_iconbutton_button_1')]")
	private WebElement controlCenterScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'control_center_screen_iconbutton_button_2')]")
	private WebElement controlCenterScreenIconbuttonButton2;

    public Clinic837ControlcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic837ControlcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic837ControlcenterscreenScreen", "/governance/control-center");
    }
}

