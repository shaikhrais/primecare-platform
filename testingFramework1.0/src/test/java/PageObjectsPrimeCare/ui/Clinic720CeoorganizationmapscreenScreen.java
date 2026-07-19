package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic720CeoorganizationmapscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 720;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_organization_map-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_organization_map-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_organization_map-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceoorganizationmapscreen-screen')]")
	private WebElement ceoorganizationmapscreenScreen;

    public Clinic720CeoorganizationmapscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic720CeoorganizationmapscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic720CeoorganizationmapscreenScreen", "/offices/corporate/roles/ceo/organization-map");
    }
}
