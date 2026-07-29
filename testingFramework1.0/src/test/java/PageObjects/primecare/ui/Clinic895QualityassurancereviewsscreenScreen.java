package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic895QualityassurancereviewsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 895;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_reviews-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_reviews-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_reviews-content')]")
	private WebElement primaryContent;

    public Clinic895QualityassurancereviewsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic895QualityassurancereviewsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic895QualityassurancereviewsscreenScreen", "/generated/quality-assurance-reviews");
    }
}

