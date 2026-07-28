package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic300ChiropractorcommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 300;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcommandcenter-screen')]")
	private WebElement chiropractorcommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcommandcenter-title')]")
	private WebElement chiropractorcommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcommandcenter-btn-1')]")
	private WebElement chiropractorcommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcommandcenter-btn-2')]")
	private WebElement chiropractorcommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcommandcenter-btn-3')]")
	private WebElement chiropractorcommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorcommandcenter-content')]")
	private WebElement chiropractorcommandcenterContent;

    public Clinic300ChiropractorcommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic300ChiropractorcommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic300ChiropractorcommandcenterscreenScreen", "/offices/clinical/roles/chiropractor/command-center");
    }
}

