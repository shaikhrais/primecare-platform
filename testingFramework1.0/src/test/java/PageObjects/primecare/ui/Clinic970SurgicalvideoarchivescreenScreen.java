package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic970SurgicalvideoarchivescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 970;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'surgical_video_archive-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'surgical_video_archive-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'surgical_video_archive-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'surgical_video_archive_iconbutton_button_1')]")
	private WebElement surgicalVideoArchiveIconbuttonButton1;

    public Clinic970SurgicalvideoarchivescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic970SurgicalvideoarchivescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic970SurgicalvideoarchivescreenScreen", "/generated/surgical-video-archive");
    }
}

