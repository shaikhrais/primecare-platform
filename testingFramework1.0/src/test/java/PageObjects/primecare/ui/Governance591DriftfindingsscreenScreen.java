package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance591DriftfindingsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 591;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'drift_findings-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'drift_findings-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'drift_findings-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-screen')]")
	private WebElement driftfindingsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-btn-2')]")
	private WebElement driftfindingsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-btn-3')]")
	private WebElement driftfindingsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-btn-1')]")
	private WebElement driftfindingsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-loading')]")
	private WebElement driftfindingsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-title')]")
	private WebElement driftfindingsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'driftfindings-content')]")
	private WebElement driftfindingsContent;

    public Governance591DriftfindingsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance591DriftfindingsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance591DriftfindingsscreenScreen", "/common/drift-findings");
    }
}

