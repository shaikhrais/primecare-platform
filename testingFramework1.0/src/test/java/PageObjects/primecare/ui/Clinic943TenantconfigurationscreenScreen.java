package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic943TenantconfigurationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 943;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tenant_configuration-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tenant_configuration-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tenant_configuration-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tenant_configuration_screen_outlinedbutton_button_1')]")
	private WebElement tenantConfigurationScreenOutlinedbuttonButton1;

    public Clinic943TenantconfigurationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic943TenantconfigurationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic943TenantconfigurationscreenScreen", "/generated/tenant-configuration");
    }
}

