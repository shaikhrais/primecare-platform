package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic842RegionalperformancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 842;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_performance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_performance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_performance-content')]")
	private WebElement primaryContent;

    public Clinic842RegionalperformancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic842RegionalperformancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic842RegionalperformancescreenScreen", "/generated/offices/corporate/roles/ceo/region-performance");
    }
}
