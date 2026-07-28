package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic378RpncommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 378;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-loading')]")
	private WebElement rpncommandcenterLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-btn-3')]")
	private WebElement rpncommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-btn-1')]")
	private WebElement rpncommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-btn-2')]")
	private WebElement rpncommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-title')]")
	private WebElement rpncommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-screen')]")
	private WebElement rpncommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncommandcenter-content')]")
	private WebElement rpncommandcenterContent;

    public Clinic378RpncommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic378RpncommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic378RpncommandcenterscreenScreen", "/offices/clinical/roles/rpn/rpn-command-center");
    }
}

