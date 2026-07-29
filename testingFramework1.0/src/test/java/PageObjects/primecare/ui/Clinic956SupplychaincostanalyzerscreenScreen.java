package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic956SupplychaincostanalyzerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 956;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supply_chain_cost_analyzer-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supply_chain_cost_analyzer-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supply_chain_cost_analyzer-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supply_chain_cost_analyzer_iconbutton_button_1')]")
	private WebElement supplyChainCostAnalyzerIconbuttonButton1;

    public Clinic956SupplychaincostanalyzerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic956SupplychaincostanalyzerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic956SupplychaincostanalyzerscreenScreen", "/generated/supply-chain-cost-analyzer");
    }
}

