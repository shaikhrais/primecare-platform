package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise602Franchisecommandcenter4kscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 602;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_command_center4_k-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_command_center4_k-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_command_center4_k-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter4k-btn-1')]")
	private WebElement franchisecommandcenter4kBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter4k-title')]")
	private WebElement franchisecommandcenter4kTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter4k-btn-3')]")
	private WebElement franchisecommandcenter4kBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter4k-content')]")
	private WebElement franchisecommandcenter4kContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter4k-screen')]")
	private WebElement franchisecommandcenter4kScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter4k-btn-2')]")
	private WebElement franchisecommandcenter4kBtn2;

    public Franchise602Franchisecommandcenter4kscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise602Franchisecommandcenter4kscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise602Franchisecommandcenter4kscreenScreen", "/executive/franchise-command-center4-k");
    }
}
