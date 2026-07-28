package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic721CeoregionperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 721;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_region_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_region_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_region_performance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceoregionperformancescreen-screen')]")
	private WebElement ceoregionperformancescreenScreen;

    public Clinic721CeoregionperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic721CeoregionperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic721CeoregionperformancescreenScreen", "/offices/corporate/roles/ceo/region-performance");
    }
}

