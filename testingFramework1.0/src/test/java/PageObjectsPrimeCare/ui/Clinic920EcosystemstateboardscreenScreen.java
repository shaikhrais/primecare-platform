package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic920EcosystemstateboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 920;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ecosystem_state_board-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ecosystem_state_board-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ecosystem_state_board-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ecosystem_state_board_iconbutton_button_1')]")
	private WebElement ecosystemStateBoardIconbuttonButton1;

    public Clinic920EcosystemstateboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic920EcosystemstateboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic920EcosystemstateboardscreenScreen", "/generated/ecosystem-state-board");
    }
}
