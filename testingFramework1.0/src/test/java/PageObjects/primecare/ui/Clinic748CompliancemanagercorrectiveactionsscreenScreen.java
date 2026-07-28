package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic748CompliancemanagercorrectiveactionsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 748;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_corrective_actions-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_corrective_actions-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_corrective_actions-content')]")
	private WebElement primaryContent;

    public Clinic748CompliancemanagercorrectiveactionsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic748CompliancemanagercorrectiveactionsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic748CompliancemanagercorrectiveactionsscreenScreen", "/generated/compliance-manager-corrective-actions");
    }
}

