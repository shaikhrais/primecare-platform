package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic874TerritorysalesmanagerconversionsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 874;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_conversions-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_conversions-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_conversions-content')]")
	private WebElement primaryContent;

    public Clinic874TerritorysalesmanagerconversionsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic874TerritorysalesmanagerconversionsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic874TerritorysalesmanagerconversionsscreenScreen", "/generated/territory-sales-manager-conversions");
    }
}
