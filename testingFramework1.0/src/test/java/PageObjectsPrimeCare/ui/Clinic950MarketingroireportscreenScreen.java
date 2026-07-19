package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic950MarketingroireportscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 950;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_r_o_i_report-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_r_o_i_report-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_r_o_i_report-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_roi_report_iconbutton_button_1')]")
	private WebElement marketingRoiReportIconbuttonButton1;

    public Clinic950MarketingroireportscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic950MarketingroireportscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic950MarketingroireportscreenScreen", "/generated/marketing-r-o-i-report");
    }
}
