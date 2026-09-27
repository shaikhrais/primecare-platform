package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic728CfofranchisefinancialsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 728;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_franchise_financials-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_franchise_financials-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_franchise_financials-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfofranchisefinancialsscreen-screen')]")
	private WebElement cfofranchisefinancialsscreenScreen;

    public Clinic728CfofranchisefinancialsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic728CfofranchisefinancialsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic728CfofranchisefinancialsscreenScreen", "/offices/corporate/roles/cfo/franchise-financials");
    }
}

