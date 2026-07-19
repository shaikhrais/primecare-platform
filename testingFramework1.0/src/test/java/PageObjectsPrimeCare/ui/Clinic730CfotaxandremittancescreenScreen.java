package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic730CfotaxandremittancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 730;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_tax_and_remittance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_tax_and_remittance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_tax_and_remittance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfotaxandremittancescreen-screen')]")
	private WebElement cfotaxandremittancescreenScreen;

    public Clinic730CfotaxandremittancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic730CfotaxandremittancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic730CfotaxandremittancescreenScreen", "/offices/corporate/roles/cfo/tax-and-remittance");
    }
}
