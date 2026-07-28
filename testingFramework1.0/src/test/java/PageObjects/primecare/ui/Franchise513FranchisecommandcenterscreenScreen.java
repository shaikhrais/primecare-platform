package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise513FranchisecommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 513;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter-btn-3')]")
	private WebElement franchisecommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter-screen')]")
	private WebElement franchisecommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter-btn-1')]")
	private WebElement franchisecommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter-title')]")
	private WebElement franchisecommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter-content')]")
	private WebElement franchisecommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecommandcenter-btn-2')]")
	private WebElement franchisecommandcenterBtn2;

    public Franchise513FranchisecommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise513FranchisecommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise513FranchisecommandcenterscreenScreen", "/executive/franchise-command-center");
    }
}

