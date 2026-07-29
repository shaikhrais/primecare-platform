package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic740CoobranchoperationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 740;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_branch_operations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_branch_operations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_branch_operations-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coobranchoperationsscreen-screen')]")
	private WebElement coobranchoperationsscreenScreen;

    public Clinic740CoobranchoperationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic740CoobranchoperationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic740CoobranchoperationsscreenScreen", "/offices/corporate/roles/coo/branch-operations");
    }
}

