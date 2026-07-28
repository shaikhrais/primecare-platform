package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic805FranchiseownerhiringscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 805;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_hiring-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_hiring-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_hiring-content')]")
	private WebElement primaryContent;

    public Clinic805FranchiseownerhiringscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic805FranchiseownerhiringscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic805FranchiseownerhiringscreenScreen", "/offices/franchise/roles/franchise_owner/hiring");
    }
}

