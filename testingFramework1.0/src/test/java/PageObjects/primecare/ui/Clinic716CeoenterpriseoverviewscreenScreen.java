package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic716CeoenterpriseoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 716;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_enterprise_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_enterprise_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_enterprise_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceoenterpriseoverviewscreen-screen')]")
	private WebElement ceoenterpriseoverviewscreenScreen;

    public Clinic716CeoenterpriseoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic716CeoenterpriseoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic716CeoenterpriseoverviewscreenScreen", "/offices/corporate/roles/ceo/enterprise-overview");
    }
}

