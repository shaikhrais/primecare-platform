package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance593AgentdispatchscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 593;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agent_dispatch-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agent_dispatch-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agent_dispatch-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-screen')]")
	private WebElement agentdispatchScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-title')]")
	private WebElement agentdispatchTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-content')]")
	private WebElement agentdispatchContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-btn-3')]")
	private WebElement agentdispatchBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-loading')]")
	private WebElement agentdispatchLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-btn-2')]")
	private WebElement agentdispatchBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'agentdispatch-btn-1')]")
	private WebElement agentdispatchBtn1;

    public Governance593AgentdispatchscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance593AgentdispatchscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance593AgentdispatchscreenScreen", "/common/agent-dispatch");
    }
}

