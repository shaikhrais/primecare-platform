package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic927MessagearchiveerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 927;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archiveer-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archiveer-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archiveer-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archive_viewer_iconbutton_button_2')]")
	private WebElement messageArchiveViewerIconbuttonButton2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archive_viewer_textfield_input_1')]")
	private WebElement messageArchiveViewerTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archive_viewer_textbutton_button_1')]")
	private WebElement messageArchiveViewerTextbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'message_archive_viewer_iconbutton_button_1')]")
	private WebElement messageArchiveViewerIconbuttonButton1;

    public Clinic927MessagearchiveerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic927MessagearchiveerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic927MessagearchiveerscreenScreen", "/generated/message-archiveer");
    }
}

