package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic806HrhiringreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 806;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_reports-content')]")
	private WebElement primaryContent;

    public Clinic806HrhiringreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic806HrhiringreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic806HrhiringreportsscreenScreen", "/offices/franchise/roles/hr_hiring/reports");
    }
}

