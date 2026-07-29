package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic894QualityassurancereportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 894;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_reports-content')]")
	private WebElement primaryContent;

    public Clinic894QualityassurancereportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic894QualityassurancereportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic894QualityassurancereportsscreenScreen", "/generated/quality-assurance-reports");
    }
}

