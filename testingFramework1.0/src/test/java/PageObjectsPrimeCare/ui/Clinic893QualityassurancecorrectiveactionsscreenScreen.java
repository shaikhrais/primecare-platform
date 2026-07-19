package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic893QualityassurancecorrectiveactionsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 893;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_corrective_actions-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_corrective_actions-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_corrective_actions-content')]")
	private WebElement primaryContent;

    public Clinic893QualityassurancecorrectiveactionsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic893QualityassurancecorrectiveactionsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic893QualityassurancecorrectiveactionsscreenScreen", "/generated/quality-assurance-corrective-actions");
    }
}
