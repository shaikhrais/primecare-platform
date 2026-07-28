package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic724CeostrategickpisscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 724;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_strategic_kpis-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_strategic_kpis-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_strategic_kpis-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceostrategickpisscreen-screen')]")
	private WebElement ceostrategickpisscreenScreen;

    public Clinic724CeostrategickpisscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic724CeostrategickpisscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic724CeostrategickpisscreenScreen", "/offices/corporate/roles/ceo/strategic-kpis");
    }
}

