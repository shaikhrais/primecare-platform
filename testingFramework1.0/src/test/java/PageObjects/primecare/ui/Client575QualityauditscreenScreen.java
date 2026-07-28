package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client575QualityauditscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 575;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_audit-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_audit-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_audit-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-loading')]")
	private WebElement qualityauditLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-title')]")
	private WebElement qualityauditTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-btn-3')]")
	private WebElement qualityauditBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-btn-1')]")
	private WebElement qualityauditBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-btn-2')]")
	private WebElement qualityauditBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-screen')]")
	private WebElement qualityauditScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-btn-5')]")
	private WebElement qualityauditBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-content')]")
	private WebElement qualityauditContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityaudit-btn-4')]")
	private WebElement qualityauditBtn4;

    public Client575QualityauditscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client575QualityauditscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client575QualityauditscreenScreen", "/staff/quality-audit");
    }
}

