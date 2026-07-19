package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate315CoooperationsoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 315;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_operations_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_operations_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_operations_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coooperationsoverview-title')]")
	private WebElement coooperationsoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coooperationsoverview-btn-3')]")
	private WebElement coooperationsoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coooperationsoverview-btn-1')]")
	private WebElement coooperationsoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coooperationsoverview-btn-2')]")
	private WebElement coooperationsoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coooperationsoverview-screen')]")
	private WebElement coooperationsoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coooperationsoverview-content')]")
	private WebElement coooperationsoverviewContent;

    public Corporate315CoooperationsoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate315CoooperationsoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate315CoooperationsoverviewscreenScreen", "/offices/corporate/roles/coo/operations-overview");
    }
}
