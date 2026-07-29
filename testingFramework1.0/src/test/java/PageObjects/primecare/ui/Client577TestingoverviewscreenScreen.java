package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client577TestingoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 577;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testing_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testing_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testing_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-btn-1')]")
	private WebElement testingoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-content')]")
	private WebElement testingoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-screen')]")
	private WebElement testingoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-btn-5')]")
	private WebElement testingoverviewBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-title')]")
	private WebElement testingoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-loading')]")
	private WebElement testingoverviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-btn-4')]")
	private WebElement testingoverviewBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-btn-2')]")
	private WebElement testingoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'testingoverview-btn-3')]")
	private WebElement testingoverviewBtn3;

    public Client577TestingoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client577TestingoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client577TestingoverviewscreenScreen", "/staff/testing-overview");
    }
}

