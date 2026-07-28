package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic797AdminoutstandingbalancesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 797;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_outstanding_balances-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_outstanding_balances-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_outstanding_balances-content')]")
	private WebElement primaryContent;

    public Clinic797AdminoutstandingbalancesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic797AdminoutstandingbalancesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic797AdminoutstandingbalancesscreenScreen", "/offices/franchise/roles/admin/outstanding-balances");
    }
}

