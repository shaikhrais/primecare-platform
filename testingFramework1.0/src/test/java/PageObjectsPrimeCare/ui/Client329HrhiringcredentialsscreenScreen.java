package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client329HrhiringcredentialsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 329;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_credentials-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_credentials-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_credentials-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-btn-2')]")
	private WebElement hrhiringcredentialsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-content')]")
	private WebElement hrhiringcredentialsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-btn-1')]")
	private WebElement hrhiringcredentialsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-btn-3')]")
	private WebElement hrhiringcredentialsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-screen')]")
	private WebElement hrhiringcredentialsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-btn-4')]")
	private WebElement hrhiringcredentialsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-btn-5')]")
	private WebElement hrhiringcredentialsBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringcredentials-title')]")
	private WebElement hrhiringcredentialsTitle;

    public Client329HrhiringcredentialsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client329HrhiringcredentialsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client329HrhiringcredentialsscreenScreen", "/offices/franchise/roles/hr_hiring/credentials");
    }
}
