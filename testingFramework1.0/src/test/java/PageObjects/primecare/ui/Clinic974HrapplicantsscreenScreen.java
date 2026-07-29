package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic974HrapplicantsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 974;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_applicants-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_applicants-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_applicants-content')]")
	private WebElement primaryContent;

    public Clinic974HrapplicantsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic974HrapplicantsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic974HrapplicantsscreenScreen", "/generated/hr-applicants");
    }
}

