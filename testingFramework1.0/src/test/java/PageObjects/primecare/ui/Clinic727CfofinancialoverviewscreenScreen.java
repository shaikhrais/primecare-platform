package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic727CfofinancialoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 727;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_financial_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_financial_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_financial_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfofinancialoverviewscreen-screen')]")
	private WebElement cfofinancialoverviewscreenScreen;

    public Clinic727CfofinancialoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic727CfofinancialoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic727CfofinancialoverviewscreenScreen", "/offices/corporate/roles/cfo/financial-overview");
    }
}

