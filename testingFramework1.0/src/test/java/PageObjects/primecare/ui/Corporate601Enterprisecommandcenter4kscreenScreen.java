package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate601Enterprisecommandcenter4kscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 601;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprise_command_center4_k-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprise_command_center4_k-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprise_command_center4_k-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisecommandcenter4k-btn-2')]")
	private WebElement enterprisecommandcenter4kBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisecommandcenter4k-screen')]")
	private WebElement enterprisecommandcenter4kScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisecommandcenter4k-btn-3')]")
	private WebElement enterprisecommandcenter4kBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisecommandcenter4k-title')]")
	private WebElement enterprisecommandcenter4kTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisecommandcenter4k-btn-1')]")
	private WebElement enterprisecommandcenter4kBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisecommandcenter4k-content')]")
	private WebElement enterprisecommandcenter4kContent;

    public Corporate601Enterprisecommandcenter4kscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate601Enterprisecommandcenter4kscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate601Enterprisecommandcenter4kscreenScreen", "/executive/enterprise-command-center4-k");
    }
}

