package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class BusinessDevelopment59HeadofbusdevdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 59;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_dashboard-content')]")
	private WebElement primaryContent;

    public BusinessDevelopment59HeadofbusdevdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public BusinessDevelopment59HeadofbusdevdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "BusinessDevelopment59HeadofbusdevdashboardscreenScreen", "/offices/corporate/roles/head_of_bus_dev/dashboard");
    }
}

