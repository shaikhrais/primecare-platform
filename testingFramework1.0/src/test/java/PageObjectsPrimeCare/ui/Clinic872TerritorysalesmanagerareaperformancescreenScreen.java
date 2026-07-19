package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic872TerritorysalesmanagerareaperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 872;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_area_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_area_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_area_performance-content')]")
	private WebElement primaryContent;

    public Clinic872TerritorysalesmanagerareaperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic872TerritorysalesmanagerareaperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic872TerritorysalesmanagerareaperformancescreenScreen", "/generated/territory-sales-manager-area-performance");
    }
}
