package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic873TerritorysalesmanagercompetitorsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 873;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_competitors-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_competitors-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_competitors-content')]")
	private WebElement primaryContent;

    public Clinic873TerritorysalesmanagercompetitorsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic873TerritorysalesmanagercompetitorsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic873TerritorysalesmanagercompetitorsscreenScreen", "/generated/territory-sales-manager-competitors");
    }
}
