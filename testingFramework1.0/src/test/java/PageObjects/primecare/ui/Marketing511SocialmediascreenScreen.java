package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Marketing511SocialmediascreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 511;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-btn-2')]")
	private WebElement socialmediaBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-btn-1')]")
	private WebElement socialmediaBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-title')]")
	private WebElement socialmediaTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-screen')]")
	private WebElement socialmediaScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-loading')]")
	private WebElement socialmediaLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-btn-3')]")
	private WebElement socialmediaBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialmedia-content')]")
	private WebElement socialmediaContent;

    public Marketing511SocialmediascreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Marketing511SocialmediascreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Marketing511SocialmediascreenScreen", "/management/social-media");
    }
}

