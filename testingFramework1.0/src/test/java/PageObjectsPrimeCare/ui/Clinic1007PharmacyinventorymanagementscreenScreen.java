package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1007PharmacyinventorymanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1007;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pharmacy_inventory_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pharmacy_inventory_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pharmacy_inventory_management-content')]")
	private WebElement primaryContent;

    public Clinic1007PharmacyinventorymanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1007PharmacyinventorymanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1007PharmacyinventorymanagementscreenScreen", "/generated/pharmacy-inventory-management");
    }
}
