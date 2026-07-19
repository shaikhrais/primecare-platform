package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic944TouchpointanalyzerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 944;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'touchpoint_analyzer-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'touchpoint_analyzer-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'touchpoint_analyzer-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'touchpoint_analyzer_screen_iconbutton_button_1')]")
	private WebElement touchpointAnalyzerScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'touchpoint_analyzer_screen_textbutton_button_1')]")
	private WebElement touchpointAnalyzerScreenTextbuttonButton1;

    public Clinic944TouchpointanalyzerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic944TouchpointanalyzerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic944TouchpointanalyzerscreenScreen", "/generated/touchpoint-analyzer");
    }
}
