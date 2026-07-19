package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client518DailyoperationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 518;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'daily_operations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'daily_operations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'daily_operations-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-btn-3')]")
	private WebElement dailyoperationsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-btn-2')]")
	private WebElement dailyoperationsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-screen')]")
	private WebElement dailyoperationsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-loading')]")
	private WebElement dailyoperationsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-title')]")
	private WebElement dailyoperationsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-btn-1')]")
	private WebElement dailyoperationsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dailyoperations-content')]")
	private WebElement dailyoperationsContent;

    public Client518DailyoperationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client518DailyoperationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client518DailyoperationsscreenScreen", "/management/daily-operations");
    }
}
