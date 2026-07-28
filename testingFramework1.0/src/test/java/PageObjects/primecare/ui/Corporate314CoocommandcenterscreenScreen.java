package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate314CoocommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 314;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-btn-1')]")
	private WebElement coocommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-content')]")
	private WebElement coocommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-screen')]")
	private WebElement coocommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-loading')]")
	private WebElement coocommandcenterLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-title')]")
	private WebElement coocommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-btn-3')]")
	private WebElement coocommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocommandcenter-btn-2')]")
	private WebElement coocommandcenterBtn2;

    public Corporate314CoocommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate314CoocommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate314CoocommandcenterscreenScreen", "/executive/coo-command-center");
    }
}

