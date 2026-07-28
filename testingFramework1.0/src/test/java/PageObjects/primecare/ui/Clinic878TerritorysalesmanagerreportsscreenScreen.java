package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic878TerritorysalesmanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 878;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic878TerritorysalesmanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic878TerritorysalesmanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic878TerritorysalesmanagerreportsscreenScreen", "/generated/territory-sales-manager-reports");
    }
}

