package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client327HrhiringoffersscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 327;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_offers-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_offers-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_offers-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-btn-4')]")
	private WebElement hrhiringoffersBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-btn-1')]")
	private WebElement hrhiringoffersBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-screen')]")
	private WebElement hrhiringoffersScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-btn-2')]")
	private WebElement hrhiringoffersBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-loading')]")
	private WebElement hrhiringoffersLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-btn-3')]")
	private WebElement hrhiringoffersBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-btn-5')]")
	private WebElement hrhiringoffersBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-title')]")
	private WebElement hrhiringoffersTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringoffers-content')]")
	private WebElement hrhiringoffersContent;

    public Client327HrhiringoffersscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client327HrhiringoffersscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client327HrhiringoffersscreenScreen", "/offices/franchise/roles/hr_hiring/offers");
    }
}

