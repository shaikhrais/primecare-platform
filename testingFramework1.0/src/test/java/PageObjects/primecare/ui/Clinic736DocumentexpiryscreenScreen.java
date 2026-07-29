package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic736DocumentexpiryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 736;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'document_expiry-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'document_expiry-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'document_expiry-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documentexpiryscreen-screen')]")
	private WebElement documentexpiryscreenScreen;

    public Clinic736DocumentexpiryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic736DocumentexpiryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic736DocumentexpiryscreenScreen", "/offices/corporate/roles/compliance_manager/document-expiry");
    }
}

