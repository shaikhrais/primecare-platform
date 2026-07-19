package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client582DocumentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 582;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-btn-1')]")
	private WebElement documentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-btn-3')]")
	private WebElement documentsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-loading')]")
	private WebElement documentsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'documents-btn-2')]")
	private WebElement documentsBtn2;

    public Client582DocumentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client582DocumentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client582DocumentsscreenScreen", "/common/documents");
    }
}
