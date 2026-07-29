package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance590RuntimeverificationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 590;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtime_verification-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtime_verification-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtime_verification-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtimeverification-btn-1')]")
	private WebElement runtimeverificationBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtimeverification-btn-3')]")
	private WebElement runtimeverificationBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtimeverification-title')]")
	private WebElement runtimeverificationTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtimeverification-screen')]")
	private WebElement runtimeverificationScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtimeverification-content')]")
	private WebElement runtimeverificationContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'runtimeverification-btn-2')]")
	private WebElement runtimeverificationBtn2;

    public Governance590RuntimeverificationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance590RuntimeverificationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance590RuntimeverificationscreenScreen", "/common/runtime-verification");
    }
}

