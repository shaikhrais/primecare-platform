package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic896QualityassurancescorecardsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 896;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_scorecards-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_scorecards-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_scorecards-content')]")
	private WebElement primaryContent;

    public Clinic896QualityassurancescorecardsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic896QualityassurancescorecardsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic896QualityassurancescorecardsscreenScreen", "/generated/quality-assurance-scorecards");
    }
}

