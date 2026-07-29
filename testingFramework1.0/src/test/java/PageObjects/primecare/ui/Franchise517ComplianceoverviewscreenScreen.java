package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise517ComplianceoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 517;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'complianceoverview-screen')]")
	private WebElement complianceoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'complianceoverview-content')]")
	private WebElement complianceoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'complianceoverview-btn-1')]")
	private WebElement complianceoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'complianceoverview-btn-2')]")
	private WebElement complianceoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'complianceoverview-btn-3')]")
	private WebElement complianceoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'complianceoverview-title')]")
	private WebElement complianceoverviewTitle;

    public Franchise517ComplianceoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise517ComplianceoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise517ComplianceoverviewscreenScreen", "/executive/compliance-overview");
    }
}

