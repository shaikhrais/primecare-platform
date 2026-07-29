package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic743CooservicedeliveryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 743;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_service_delivery-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_service_delivery-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_service_delivery-content')]")
	private WebElement primaryContent;

    public Clinic743CooservicedeliveryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic743CooservicedeliveryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic743CooservicedeliveryscreenScreen", "/offices/corporate/roles/coo/service-delivery");
    }
}

