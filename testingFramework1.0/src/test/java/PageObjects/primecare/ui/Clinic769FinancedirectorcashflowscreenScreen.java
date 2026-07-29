package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic769FinancedirectorcashflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 769;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_cashflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_cashflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_cashflow-content')]")
	private WebElement primaryContent;

    public Clinic769FinancedirectorcashflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic769FinancedirectorcashflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic769FinancedirectorcashflowscreenScreen", "/offices/corporate/roles/finance_director/cashflow");
    }
}

