package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic875TerritorysalesmanagerfieldactivityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 875;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_field_activity-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_field_activity-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_field_activity-content')]")
	private WebElement primaryContent;

    public Clinic875TerritorysalesmanagerfieldactivityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic875TerritorysalesmanagerfieldactivityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic875TerritorysalesmanagerfieldactivityscreenScreen", "/generated/territory-sales-manager-field-activity");
    }
}

