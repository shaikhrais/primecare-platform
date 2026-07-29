package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic939SecuremessagecenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 939;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center_iconbutton_button_1')]")
	private WebElement secureMessageCenterIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center_textfield_input_1')]")
	private WebElement secureMessageCenterTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center_iconbutton_button_2')]")
	private WebElement secureMessageCenterIconbuttonButton2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center_textfield_input_2')]")
	private WebElement secureMessageCenterTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center_iconbutton_button_5')]")
	private WebElement secureMessageCenterIconbuttonButton5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'secure_message_center_iconbutton_button_3')]")
	private WebElement secureMessageCenterIconbuttonButton3;

    public Clinic939SecuremessagecenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic939SecuremessagecenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic939SecuremessagecenterscreenScreen", "/generated/secure-message-center");
    }
}

