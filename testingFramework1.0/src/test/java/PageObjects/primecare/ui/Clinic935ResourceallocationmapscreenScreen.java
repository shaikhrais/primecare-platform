package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic935ResourceallocationmapscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 935;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resource_allocation_map-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resource_allocation_map-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resource_allocation_map-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resource_allocation_map_iconbutton_button_1')]")
	private WebElement resourceAllocationMapIconbuttonButton1;

    public Clinic935ResourceallocationmapscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic935ResourceallocationmapscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic935ResourceallocationmapscreenScreen", "/generated/resource-allocation-map");
    }
}

