package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client527ClaimsprocessingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 527;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claims_processing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claims_processing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claims_processing-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-screen')]")
	private WebElement claimsprocessingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-loading')]")
	private WebElement claimsprocessingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-btn-3')]")
	private WebElement claimsprocessingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-content')]")
	private WebElement claimsprocessingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-btn-2')]")
	private WebElement claimsprocessingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-title')]")
	private WebElement claimsprocessingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-btn-5')]")
	private WebElement claimsprocessingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-btn-1')]")
	private WebElement claimsprocessingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'claimsprocessing-btn-4')]")
	private WebElement claimsprocessingBtn4;

    public Client527ClaimsprocessingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client527ClaimsprocessingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client527ClaimsprocessingscreenScreen", "/staff/claims-processing");
    }
}

