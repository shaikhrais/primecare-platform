package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1025ResearchprotocolmanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1025;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'research_protocol_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'research_protocol_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'research_protocol_manager-content')]")
	private WebElement primaryContent;

    public Clinic1025ResearchprotocolmanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1025ResearchprotocolmanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1025ResearchprotocolmanagerscreenScreen", "/generated/research-protocol-manager");
    }
}
