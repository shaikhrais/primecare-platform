package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic734CorrectiveactionsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 734;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'corrective_actions-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'corrective_actions-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'corrective_actions-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'correctiveactionsscreen-screen')]")
	private WebElement correctiveactionsscreenScreen;

    public Clinic734CorrectiveactionsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic734CorrectiveactionsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic734CorrectiveactionsscreenScreen", "/offices/corporate/roles/compliance_manager/corrective-actions");
    }
}

