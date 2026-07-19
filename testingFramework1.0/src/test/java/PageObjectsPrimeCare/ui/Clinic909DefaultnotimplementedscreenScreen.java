package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic909DefaultnotimplementedscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 909;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'default_not_implemented-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'default_not_implemented-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'default_not_implemented-content')]")
	private WebElement primaryContent;

    public Clinic909DefaultnotimplementedscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic909DefaultnotimplementedscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic909DefaultnotimplementedscreenScreen", "/generated/default-not-implemented");
    }
}
