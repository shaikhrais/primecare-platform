package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic642FranchisesalesmanagerfollowupsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 642;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_follow_ups-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_follow_ups-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_follow_ups-content')]")
	private WebElement primaryContent;

    public Clinic642FranchisesalesmanagerfollowupsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic642FranchisesalesmanagerfollowupsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic642FranchisesalesmanagerfollowupsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/follow-ups");
    }
}

