package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance604Governanceoperations4kscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 604;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_operations4_k-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_operations4_k-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_operations4_k-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceoperations4k-btn-3')]")
	private WebElement governanceoperations4kBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceoperations4k-content')]")
	private WebElement governanceoperations4kContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceoperations4k-screen')]")
	private WebElement governanceoperations4kScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceoperations4k-title')]")
	private WebElement governanceoperations4kTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceoperations4k-btn-1')]")
	private WebElement governanceoperations4kBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceoperations4k-btn-2')]")
	private WebElement governanceoperations4kBtn2;

    public Governance604Governanceoperations4kscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance604Governanceoperations4kscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance604Governanceoperations4kscreenScreen", "/common/governance-operations4-k");
    }
}

