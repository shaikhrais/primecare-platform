package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client569CommunicationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 569;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-loading')]")
	private WebElement communicationLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-btn-4')]")
	private WebElement communicationBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-btn-1')]")
	private WebElement communicationBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-btn-2')]")
	private WebElement communicationBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-btn-5')]")
	private WebElement communicationBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communication-btn-3')]")
	private WebElement communicationBtn3;

    public Client569CommunicationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client569CommunicationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client569CommunicationscreenScreen", "/staff/communication");
    }
}

