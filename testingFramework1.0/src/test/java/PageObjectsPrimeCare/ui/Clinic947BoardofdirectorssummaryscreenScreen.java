package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic947BoardofdirectorssummaryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 947;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'board_of_directors_summary-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'board_of_directors_summary-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'board_of_directors_summary-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'board_of_directors_summary_iconbutton_button_1')]")
	private WebElement boardOfDirectorsSummaryIconbuttonButton1;

    public Clinic947BoardofdirectorssummaryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic947BoardofdirectorssummaryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic947BoardofdirectorssummaryscreenScreen", "/generated/board-of-directors-summary");
    }
}
