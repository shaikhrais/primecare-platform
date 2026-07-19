package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client386SchedulercommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 386;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-btn-3')]")
	private WebElement schedulercommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-btn-4')]")
	private WebElement schedulercommandcenterBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-content')]")
	private WebElement schedulercommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-btn-2')]")
	private WebElement schedulercommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-screen')]")
	private WebElement schedulercommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-btn-5')]")
	private WebElement schedulercommandcenterBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-title')]")
	private WebElement schedulercommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulercommandcenter-btn-1')]")
	private WebElement schedulercommandcenterBtn1;

    public Client386SchedulercommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client386SchedulercommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client386SchedulercommandcenterscreenScreen", "/staff/scheduler-command-center");
    }
}
