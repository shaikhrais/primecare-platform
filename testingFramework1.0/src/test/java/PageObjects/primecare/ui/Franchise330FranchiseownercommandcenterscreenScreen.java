package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise330FranchiseownercommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 330;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercommandcenter-btn-1')]")
	private WebElement franchiseownercommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercommandcenter-btn-3')]")
	private WebElement franchiseownercommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercommandcenter-btn-2')]")
	private WebElement franchiseownercommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercommandcenter-title')]")
	private WebElement franchiseownercommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercommandcenter-screen')]")
	private WebElement franchiseownercommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercommandcenter-content')]")
	private WebElement franchiseownercommandcenterContent;

    public Franchise330FranchiseownercommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise330FranchiseownercommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise330FranchiseownercommandcenterscreenScreen", "/executive/franchise-owner-command-center");
    }
}

