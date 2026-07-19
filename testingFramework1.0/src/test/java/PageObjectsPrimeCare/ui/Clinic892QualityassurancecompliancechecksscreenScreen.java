package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic892QualityassurancecompliancechecksscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 892;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_compliance_checks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_compliance_checks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_compliance_checks-content')]")
	private WebElement primaryContent;

    public Clinic892QualityassurancecompliancechecksscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic892QualityassurancecompliancechecksscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic892QualityassurancecompliancechecksscreenScreen", "/generated/quality-assurance-compliance-checks");
    }
}
