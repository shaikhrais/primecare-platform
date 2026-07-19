package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic759CtofeatureadoptionscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 759;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_feature_adoption-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_feature_adoption-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_feature_adoption-content')]")
	private WebElement primaryContent;

    public Clinic759CtofeatureadoptionscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic759CtofeatureadoptionscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic759CtofeatureadoptionscreenScreen", "/offices/corporate/roles/cto/feature-adoption");
    }
}
