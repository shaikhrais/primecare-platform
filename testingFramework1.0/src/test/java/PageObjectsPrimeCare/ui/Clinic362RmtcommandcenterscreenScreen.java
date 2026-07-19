package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic362RmtcommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 362;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-loading')]")
	private WebElement rmtcommandcenterLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-title')]")
	private WebElement rmtcommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-btn-2')]")
	private WebElement rmtcommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-btn-1')]")
	private WebElement rmtcommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-screen')]")
	private WebElement rmtcommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-btn-3')]")
	private WebElement rmtcommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcommandcenter-content')]")
	private WebElement rmtcommandcenterContent;

    public Clinic362RmtcommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic362RmtcommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic362RmtcommandcenterscreenScreen", "/offices/clinical/roles/rmt/command-center");
    }
}
