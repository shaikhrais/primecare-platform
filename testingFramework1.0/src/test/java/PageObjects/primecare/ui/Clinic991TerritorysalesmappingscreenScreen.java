package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic991TerritorysalesmappingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 991;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_mapping-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_mapping-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_mapping-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_mapping_iconbutton_button_1')]")
	private WebElement territorySalesMappingIconbuttonButton1;

    public Clinic991TerritorysalesmappingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic991TerritorysalesmappingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic991TerritorysalesmappingscreenScreen", "/generated/territory-sales-mapping");
    }
}

