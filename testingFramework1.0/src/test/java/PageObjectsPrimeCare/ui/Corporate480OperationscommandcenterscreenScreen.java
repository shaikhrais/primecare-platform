package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate480OperationscommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 480;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationscommandcenter-screen')]")
	private WebElement operationscommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationscommandcenter-btn-2')]")
	private WebElement operationscommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationscommandcenter-btn-1')]")
	private WebElement operationscommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationscommandcenter-title')]")
	private WebElement operationscommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationscommandcenter-btn-3')]")
	private WebElement operationscommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationscommandcenter-content')]")
	private WebElement operationscommandcenterContent;

    public Corporate480OperationscommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate480OperationscommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate480OperationscommandcenterscreenScreen", "/executive/operations-command-center");
    }
}
