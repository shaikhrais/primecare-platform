package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic353PswcommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 353;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-title')]")
	private WebElement pswcommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-btn-2')]")
	private WebElement pswcommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-btn-1')]")
	private WebElement pswcommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-content')]")
	private WebElement pswcommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-loading')]")
	private WebElement pswcommandcenterLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-btn-3')]")
	private WebElement pswcommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcommandcenter-screen')]")
	private WebElement pswcommandcenterScreen;

    public Clinic353PswcommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic353PswcommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic353PswcommandcenterscreenScreen", "/offices/clinical/roles/psw/system-logs");
    }
}

