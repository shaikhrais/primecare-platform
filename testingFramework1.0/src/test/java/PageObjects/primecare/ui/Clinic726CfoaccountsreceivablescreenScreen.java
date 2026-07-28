package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic726CfoaccountsreceivablescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 726;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_accounts_receivable-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_accounts_receivable-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_accounts_receivable-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoaccountsreceivablescreen-screen')]")
	private WebElement cfoaccountsreceivablescreenScreen;

    public Clinic726CfoaccountsreceivablescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic726CfoaccountsreceivablescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic726CfoaccountsreceivablescreenScreen", "/offices/corporate/roles/cfo/accounts-receivable");
    }
}

