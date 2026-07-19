package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client326HrhiringinterviewsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 326;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_interviews-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_interviews-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_interviews-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-btn-1')]")
	private WebElement hrhiringinterviewsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-btn-3')]")
	private WebElement hrhiringinterviewsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-btn-5')]")
	private WebElement hrhiringinterviewsBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-btn-2')]")
	private WebElement hrhiringinterviewsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-title')]")
	private WebElement hrhiringinterviewsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-content')]")
	private WebElement hrhiringinterviewsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-screen')]")
	private WebElement hrhiringinterviewsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringinterviews-btn-4')]")
	private WebElement hrhiringinterviewsBtn4;

    public Client326HrhiringinterviewsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client326HrhiringinterviewsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client326HrhiringinterviewsscreenScreen", "/offices/franchise/roles/hr_hiring/interviews");
    }
}
