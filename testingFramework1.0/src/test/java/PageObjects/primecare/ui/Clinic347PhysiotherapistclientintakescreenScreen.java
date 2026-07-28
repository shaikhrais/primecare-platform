package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic347PhysiotherapistclientintakescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 347;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_client_intake-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_client_intake-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_client_intake-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistclientintake-btn-1')]")
	private WebElement physiotherapistclientintakeBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistclientintake-btn-2')]")
	private WebElement physiotherapistclientintakeBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistclientintake-content')]")
	private WebElement physiotherapistclientintakeContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistclientintake-title')]")
	private WebElement physiotherapistclientintakeTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistclientintake-screen')]")
	private WebElement physiotherapistclientintakeScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistclientintake-btn-3')]")
	private WebElement physiotherapistclientintakeBtn3;

    public Clinic347PhysiotherapistclientintakescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic347PhysiotherapistclientintakescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic347PhysiotherapistclientintakescreenScreen", "/offices/clinical/roles/physiotherapist/client-intake");
    }
}

