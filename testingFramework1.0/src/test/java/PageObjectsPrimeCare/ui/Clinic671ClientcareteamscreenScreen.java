package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic671ClientcareteamscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 671;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_care_team-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_care_team-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_care_team-content')]")
	private WebElement primaryContent;

    public Clinic671ClientcareteamscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic671ClientcareteamscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic671ClientcareteamscreenScreen", "/generated/client-care-team");
    }
}
