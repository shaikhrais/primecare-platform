package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic361DocumentsScreen extends baseTest {
 
    public static final int SCREEN_ID = 361;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_documents-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_documents-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_documents-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-btn-1')]")
	private WebElement pswdocumentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-content')]")
	private WebElement pswdocumentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-loading')]")
	private WebElement pswdocumentsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-title')]")
	private WebElement pswdocumentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-screen')]")
	private WebElement pswdocumentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-btn-2')]")
	private WebElement pswdocumentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswdocuments-btn-3')]")
	private WebElement pswdocumentsBtn3;

    public Clinic361DocumentsScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic361DocumentsScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic361DocumentsScreen", "/offices/clinical/roles/psw/documents");
    }
}

