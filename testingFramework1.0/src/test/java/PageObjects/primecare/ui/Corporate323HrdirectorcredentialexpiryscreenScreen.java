package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate323HrdirectorcredentialexpiryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 323;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_credential_expiry-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_credential_expiry-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_credential_expiry-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcredentialexpiry-btn-2')]")
	private WebElement hrdirectorcredentialexpiryBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcredentialexpiry-screen')]")
	private WebElement hrdirectorcredentialexpiryScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcredentialexpiry-btn-3')]")
	private WebElement hrdirectorcredentialexpiryBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcredentialexpiry-btn-1')]")
	private WebElement hrdirectorcredentialexpiryBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcredentialexpiry-content')]")
	private WebElement hrdirectorcredentialexpiryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorcredentialexpiry-title')]")
	private WebElement hrdirectorcredentialexpiryTitle;

    public Corporate323HrdirectorcredentialexpiryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate323HrdirectorcredentialexpiryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate323HrdirectorcredentialexpiryscreenScreen", "/executive/hr-director-credential-expiry");
    }
}

