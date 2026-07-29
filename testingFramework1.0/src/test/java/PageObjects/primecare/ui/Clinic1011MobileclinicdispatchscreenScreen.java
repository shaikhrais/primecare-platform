package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1011MobileclinicdispatchscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1011;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mobile_clinic_dispatch-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mobile_clinic_dispatch-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mobile_clinic_dispatch-content')]")
	private WebElement primaryContent;

    public Clinic1011MobileclinicdispatchscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1011MobileclinicdispatchscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1011MobileclinicdispatchscreenScreen", "/generated/mobile-clinic-dispatch");
    }
}

