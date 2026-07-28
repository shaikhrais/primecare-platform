package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic647FranchisesalesmanagersalespipelinescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 647;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_sales_pipeline-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_sales_pipeline-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_sales_pipeline-content')]")
	private WebElement primaryContent;

    public Clinic647FranchisesalesmanagersalespipelinescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic647FranchisesalesmanagersalespipelinescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic647FranchisesalesmanagersalespipelinescreenScreen", "/offices/business_development/roles/franchise_sales_manager/sales-pipeline");
    }
}

