package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic765CtoreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 765;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_reports-content')]")
	private WebElement primaryContent;

    public Clinic765CtoreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic765CtoreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic765CtoreportsscreenScreen", "/offices/corporate/roles/cto/reports");
    }
}

