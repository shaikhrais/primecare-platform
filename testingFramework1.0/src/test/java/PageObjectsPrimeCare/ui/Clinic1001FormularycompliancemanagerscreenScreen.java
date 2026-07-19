package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1001FormularycompliancemanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1001;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'formulary_compliance_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'formulary_compliance_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'formulary_compliance_manager-content')]")
	private WebElement primaryContent;

    public Clinic1001FormularycompliancemanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1001FormularycompliancemanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1001FormularycompliancemanagerscreenScreen", "/generated/formulary-compliance-manager");
    }
}
