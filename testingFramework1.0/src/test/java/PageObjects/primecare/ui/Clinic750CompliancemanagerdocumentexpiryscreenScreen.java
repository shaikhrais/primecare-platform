package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic750CompliancemanagerdocumentexpiryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 750;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_document_expiry-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_document_expiry-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_document_expiry-content')]")
	private WebElement primaryContent;

    public Clinic750CompliancemanagerdocumentexpiryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic750CompliancemanagerdocumentexpiryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic750CompliancemanagerdocumentexpiryscreenScreen", "/generated/compliance-manager-document-expiry");
    }
}

