package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic890QualityassuranceauditsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 890;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_audits-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_audits-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_audits-content')]")
	private WebElement primaryContent;

    public Clinic890QualityassuranceauditsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic890QualityassuranceauditsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic890QualityassuranceauditsscreenScreen", "/generated/quality-assurance-audits");
    }
}
