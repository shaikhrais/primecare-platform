package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic819RegionalmanagerbranchcomparisonscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 819;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_branch_comparison-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_branch_comparison-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_branch_comparison-content')]")
	private WebElement primaryContent;

    public Clinic819RegionalmanagerbranchcomparisonscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic819RegionalmanagerbranchcomparisonscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic819RegionalmanagerbranchcomparisonscreenScreen", "/offices/franchise/roles/regional_manager/branch_comparison");
    }
}
