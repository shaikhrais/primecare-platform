package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic982BrandassetlibraryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 982;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_asset_library-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_asset_library-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_asset_library-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'brand_asset_library_iconbutton_button_1')]")
	private WebElement brandAssetLibraryIconbuttonButton1;

    public Clinic982BrandassetlibraryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic982BrandassetlibraryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic982BrandassetlibraryscreenScreen", "/generated/brand-asset-library");
    }
}
