package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic345PhysiotherapistcommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 345;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcommandcenter-btn-2')]")
	private WebElement physiotherapistcommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcommandcenter-content')]")
	private WebElement physiotherapistcommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcommandcenter-title')]")
	private WebElement physiotherapistcommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcommandcenter-btn-3')]")
	private WebElement physiotherapistcommandcenterBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcommandcenter-btn-1')]")
	private WebElement physiotherapistcommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistcommandcenter-screen')]")
	private WebElement physiotherapistcommandcenterScreen;

    public Clinic345PhysiotherapistcommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic345PhysiotherapistcommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic345PhysiotherapistcommandcenterscreenScreen", "/offices/clinical/roles/physiotherapist/command-center");
    }
}
