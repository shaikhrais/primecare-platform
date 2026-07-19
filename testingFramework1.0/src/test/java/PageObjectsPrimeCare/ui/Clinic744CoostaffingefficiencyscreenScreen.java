package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic744CoostaffingefficiencyscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 744;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_staffing_efficiency-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_staffing_efficiency-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_staffing_efficiency-content')]")
	private WebElement primaryContent;

    public Clinic744CoostaffingefficiencyscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic744CoostaffingefficiencyscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic744CoostaffingefficiencyscreenScreen", "/offices/corporate/roles/coo/staffing-efficiency");
    }
}
