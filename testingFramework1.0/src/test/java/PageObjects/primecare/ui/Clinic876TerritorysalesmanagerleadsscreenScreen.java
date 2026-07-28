package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic876TerritorysalesmanagerleadsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 876;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_leads-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_leads-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_leads-content')]")
	private WebElement primaryContent;

    public Clinic876TerritorysalesmanagerleadsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic876TerritorysalesmanagerleadsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic876TerritorysalesmanagerleadsscreenScreen", "/generated/territory-sales-manager-leads");
    }
}

