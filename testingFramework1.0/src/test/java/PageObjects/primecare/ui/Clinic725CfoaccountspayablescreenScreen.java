package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic725CfoaccountspayablescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 725;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_accounts_payable-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_accounts_payable-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_accounts_payable-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoaccountspayablescreen-screen')]")
	private WebElement cfoaccountspayablescreenScreen;

    public Clinic725CfoaccountspayablescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic725CfoaccountspayablescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic725CfoaccountspayablescreenScreen", "/offices/corporate/roles/cfo/accounts-payable");
    }
}

