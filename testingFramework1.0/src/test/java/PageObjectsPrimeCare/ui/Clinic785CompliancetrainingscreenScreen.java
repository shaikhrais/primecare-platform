package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic785CompliancetrainingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 785;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_training-content')]")
	private WebElement primaryContent;

    public Clinic785CompliancetrainingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic785CompliancetrainingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic785CompliancetrainingscreenScreen", "/generated/compliance-training");
    }
}
