package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate321HrdirectorstafffilesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 321;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_staff_files-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_staff_files-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_staff_files-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorstafffiles-btn-2')]")
	private WebElement hrdirectorstafffilesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorstafffiles-screen')]")
	private WebElement hrdirectorstafffilesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorstafffiles-title')]")
	private WebElement hrdirectorstafffilesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorstafffiles-btn-3')]")
	private WebElement hrdirectorstafffilesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorstafffiles-content')]")
	private WebElement hrdirectorstafffilesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorstafffiles-btn-1')]")
	private WebElement hrdirectorstafffilesBtn1;

    public Corporate321HrdirectorstafffilesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate321HrdirectorstafffilesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate321HrdirectorstafffilesscreenScreen", "/executive/hr-director-staff-files");
    }
}

