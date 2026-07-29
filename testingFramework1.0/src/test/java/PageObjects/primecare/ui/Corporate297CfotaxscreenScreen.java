package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate297CfotaxscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 297;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_tax-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_tax-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_tax-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-loading')]")
	private WebElement cfotaxLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-title')]")
	private WebElement cfotaxTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-btn-1')]")
	private WebElement cfotaxBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-btn-3')]")
	private WebElement cfotaxBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-btn-2')]")
	private WebElement cfotaxBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-screen')]")
	private WebElement cfotaxScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotax-content')]")
	private WebElement cfotaxContent;

    public Corporate297CfotaxscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate297CfotaxscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate297CfotaxscreenScreen", "/executive/cfo-tax");
    }
}

