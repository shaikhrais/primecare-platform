package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic603Clinicaloperations4kscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 603;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_operations4_k-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_operations4_k-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_operations4_k-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaloperations4k-btn-1')]")
	private WebElement clinicaloperations4kBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaloperations4k-content')]")
	private WebElement clinicaloperations4kContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaloperations4k-btn-3')]")
	private WebElement clinicaloperations4kBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaloperations4k-screen')]")
	private WebElement clinicaloperations4kScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaloperations4k-title')]")
	private WebElement clinicaloperations4kTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaloperations4k-btn-2')]")
	private WebElement clinicaloperations4kBtn2;

    public Clinic603Clinicaloperations4kscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic603Clinicaloperations4kscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic603Clinicaloperations4kscreenScreen", "/offices/clinical/roles/clinical_director/operations4k");
    }
}
