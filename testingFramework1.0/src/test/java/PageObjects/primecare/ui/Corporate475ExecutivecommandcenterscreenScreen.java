package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate475ExecutivecommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 475;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executive_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executive_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executive_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executivecommandcenter-screen')]")
	private WebElement executivecommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executivecommandcenter-title')]")
	private WebElement executivecommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executivecommandcenter-btn-1')]")
	private WebElement executivecommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executivecommandcenter-btn-2')]")
	private WebElement executivecommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executivecommandcenter-btn-3')]")
	private WebElement executivecommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'executivecommandcenter-content')]")
	private WebElement executivecommandcenterContent;

    public Corporate475ExecutivecommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate475ExecutivecommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate475ExecutivecommandcenterscreenScreen", "/executive/executive-command-center");
    }
}

