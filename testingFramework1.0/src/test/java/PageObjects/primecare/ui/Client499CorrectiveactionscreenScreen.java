package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client499CorrectiveactionscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 499;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'corrective_action-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'corrective_action-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'corrective_action-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-btn-1')]")
	private WebElement correctiveactionBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-content')]")
	private WebElement correctiveactionContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-title')]")
	private WebElement correctiveactionTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-btn-2')]")
	private WebElement correctiveactionBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-screen')]")
	private WebElement correctiveactionScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-btn-3')]")
	private WebElement correctiveactionBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveaction-loading')]")
	private WebElement correctiveactionLoading;

    public Client499CorrectiveactionscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client499CorrectiveactionscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client499CorrectiveactionscreenScreen", "/management/corrective-action");
    }
}

