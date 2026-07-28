package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client584CareupdatesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 584;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_updates-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_updates-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'care_updates-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-loading')]")
	private WebElement careupdatesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-title')]")
	private WebElement careupdatesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-content')]")
	private WebElement careupdatesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-btn-1')]")
	private WebElement careupdatesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-btn-3')]")
	private WebElement careupdatesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-btn-2')]")
	private WebElement careupdatesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'careupdates-screen')]")
	private WebElement careupdatesScreen;

    public Client584CareupdatesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client584CareupdatesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client584CareupdatesscreenScreen", "/common/care-updates");
    }
}

