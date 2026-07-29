package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic763CtoplatformusagescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 763;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_platform_usage-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_platform_usage-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_platform_usage-content')]")
	private WebElement primaryContent;

    public Clinic763CtoplatformusagescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic763CtoplatformusagescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic763CtoplatformusagescreenScreen", "/offices/corporate/roles/cto/platform-usage");
    }
}

