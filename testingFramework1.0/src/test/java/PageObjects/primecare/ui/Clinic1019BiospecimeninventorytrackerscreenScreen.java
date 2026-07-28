package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1019BiospecimeninventorytrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1019;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'biospecimen_inventory_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'biospecimen_inventory_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'biospecimen_inventory_tracker-content')]")
	private WebElement primaryContent;

    public Clinic1019BiospecimeninventorytrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1019BiospecimeninventorytrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1019BiospecimeninventorytrackerscreenScreen", "/generated/biospecimen-inventory-tracker");
    }
}

