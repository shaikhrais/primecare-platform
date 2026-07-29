package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic370RncommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 370;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-loading')]")
	private WebElement rncommandcenterLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-btn-2')]")
	private WebElement rncommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-btn-1')]")
	private WebElement rncommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-title')]")
	private WebElement rncommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-screen')]")
	private WebElement rncommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-content')]")
	private WebElement rncommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncommandcenter-btn-3')]")
	private WebElement rncommandcenterBtn3;

    public Clinic370RncommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic370RncommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic370RncommandcenterscreenScreen", "/offices/clinical/roles/rn/rn-command-center");
    }
}

