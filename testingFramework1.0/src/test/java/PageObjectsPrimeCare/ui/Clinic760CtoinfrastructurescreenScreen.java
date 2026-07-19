package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic760CtoinfrastructurescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 760;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_infrastructure-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_infrastructure-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_infrastructure-content')]")
	private WebElement primaryContent;

    public Clinic760CtoinfrastructurescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic760CtoinfrastructurescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic760CtoinfrastructurescreenScreen", "/offices/corporate/roles/cto/infrastructure");
    }
}
