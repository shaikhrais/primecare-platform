package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance589GovernancecontrolroomscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 589;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_control_room-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_control_room-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_control_room-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governancecontrolroom-title')]")
	private WebElement governancecontrolroomTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governancecontrolroom-screen')]")
	private WebElement governancecontrolroomScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governancecontrolroom-btn-1')]")
	private WebElement governancecontrolroomBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governancecontrolroom-btn-2')]")
	private WebElement governancecontrolroomBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governancecontrolroom-content')]")
	private WebElement governancecontrolroomContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governancecontrolroom-btn-3')]")
	private WebElement governancecontrolroomBtn3;

    public Governance589GovernancecontrolroomscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance589GovernancecontrolroomscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance589GovernancecontrolroomscreenScreen", "/common/governance-control-room");
    }
}

