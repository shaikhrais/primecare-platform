package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate486RevenuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 486;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-btn-2')]")
	private WebElement revenueBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-btn-3')]")
	private WebElement revenueBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-loading')]")
	private WebElement revenueLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue-btn-1')]")
	private WebElement revenueBtn1;

    public Corporate486RevenuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate486RevenuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate486RevenuescreenScreen", "/executive/revenue");
    }
}

