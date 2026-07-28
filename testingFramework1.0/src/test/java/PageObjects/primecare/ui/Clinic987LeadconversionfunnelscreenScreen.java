package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic987LeadconversionfunnelscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 987;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_conversion_funnel-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_conversion_funnel-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_conversion_funnel-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_conversion_funnel_iconbutton_button_1')]")
	private WebElement leadConversionFunnelIconbuttonButton1;

    public Clinic987LeadconversionfunnelscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic987LeadconversionfunnelscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic987LeadconversionfunnelscreenScreen", "/generated/lead-conversion-funnel");
    }
}

