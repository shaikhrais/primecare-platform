package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1026ResearchpublicationdraftingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1026;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'research_publication_drafting-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'research_publication_drafting-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'research_publication_drafting-content')]")
	private WebElement primaryContent;

    public Clinic1026ResearchpublicationdraftingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1026ResearchpublicationdraftingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1026ResearchpublicationdraftingscreenScreen", "/generated/research-publication-drafting");
    }
}
