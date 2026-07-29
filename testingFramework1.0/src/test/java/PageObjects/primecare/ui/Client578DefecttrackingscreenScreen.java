package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client578DefecttrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 578;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defect_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defect_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defect_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-btn-1')]")
	private WebElement defecttrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-btn-2')]")
	private WebElement defecttrackingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-title')]")
	private WebElement defecttrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-btn-5')]")
	private WebElement defecttrackingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-loading')]")
	private WebElement defecttrackingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-btn-3')]")
	private WebElement defecttrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-content')]")
	private WebElement defecttrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-btn-4')]")
	private WebElement defecttrackingBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'defecttracking-screen')]")
	private WebElement defecttrackingScreen;

    public Client578DefecttrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client578DefecttrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client578DefecttrackingscreenScreen", "/staff/defect-tracking");
    }
}

