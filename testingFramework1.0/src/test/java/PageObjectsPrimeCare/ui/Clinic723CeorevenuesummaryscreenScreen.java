package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic723CeorevenuesummaryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 723;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_revenue_summary-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_revenue_summary-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_revenue_summary-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceorevenuesummaryscreen-screen')]")
	private WebElement ceorevenuesummaryscreenScreen;

    public Clinic723CeorevenuesummaryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic723CeorevenuesummaryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic723CeorevenuesummaryscreenScreen", "/offices/corporate/roles/ceo/revenue-summary");
    }
}
