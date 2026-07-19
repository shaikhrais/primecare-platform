package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic841ProposalsScreen extends baseTest {
 
    public static final int SCREEN_ID = 841;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'proposals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'proposals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'proposals-content')]")
	private WebElement primaryContent;

    public Clinic841ProposalsScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic841ProposalsScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic841ProposalsScreen", "/proposals");
    }
}
