package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client567TicketmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 567;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticket_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticket_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticket_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-btn-4')]")
	private WebElement ticketmanagementBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-screen')]")
	private WebElement ticketmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-btn-1')]")
	private WebElement ticketmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-btn-2')]")
	private WebElement ticketmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-loading')]")
	private WebElement ticketmanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-title')]")
	private WebElement ticketmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-btn-5')]")
	private WebElement ticketmanagementBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-content')]")
	private WebElement ticketmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ticketmanagement-btn-3')]")
	private WebElement ticketmanagementBtn3;

    public Client567TicketmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client567TicketmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client567TicketmanagementscreenScreen", "/staff/ticket-management");
    }
}

