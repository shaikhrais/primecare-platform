package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic984CompetitoranalysisboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 984;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'competitor_analysis_board-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'competitor_analysis_board-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'competitor_analysis_board-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'competitor_analysis_board_iconbutton_button_1')]")
	private WebElement competitorAnalysisBoardIconbuttonButton1;

    public Clinic984CompetitoranalysisboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic984CompetitoranalysisboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic984CompetitoranalysisboardscreenScreen", "/generated/competitor-analysis-board");
    }
}
