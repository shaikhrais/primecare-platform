package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic976HrstafffilesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 976;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_staff_files-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_staff_files-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_staff_files-content')]")
	private WebElement primaryContent;

    public Clinic976HrstafffilesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic976HrstafffilesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic976HrstafffilesscreenScreen", "/generated/hr-staff-files");
    }
}

