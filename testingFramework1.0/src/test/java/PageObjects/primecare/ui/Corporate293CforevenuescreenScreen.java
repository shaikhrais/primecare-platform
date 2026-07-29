package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate293CforevenuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 293;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_revenue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_revenue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_revenue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-screen')]")
	private WebElement cforevenueScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-btn-3')]")
	private WebElement cforevenueBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-btn-2')]")
	private WebElement cforevenueBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-btn-1')]")
	private WebElement cforevenueBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-loading')]")
	private WebElement cforevenueLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-content')]")
	private WebElement cforevenueContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cforevenue-title')]")
	private WebElement cforevenueTitle;

    public Corporate293CforevenuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate293CforevenuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate293CforevenuescreenScreen", "/offices/corporate/roles/cfo/revenue");
    }
}

