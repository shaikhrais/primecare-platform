package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic877TerritorysalesmanagerpipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 877;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_pipeline-content')]")
	private WebElement primaryContent;

    public Clinic877TerritorysalesmanagerpipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic877TerritorysalesmanagerpipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic877TerritorysalesmanagerpipelinescreenScreen", "/generated/territory-sales-manager-pipeline");
    }
}
