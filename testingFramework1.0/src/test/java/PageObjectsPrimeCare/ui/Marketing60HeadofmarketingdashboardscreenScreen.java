package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Marketing60HeadofmarketingdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 60;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_dashboard_iconbutton_button_1')]")
	private WebElement headOfMarketingDashboardIconbuttonButton1;

    public Marketing60HeadofmarketingdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Marketing60HeadofmarketingdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Marketing60HeadofmarketingdashboardscreenScreen", "/offices/corporate/roles/head_of_marketing/dashboard");
    }
}
