package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic934RegulatorychangeradarscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 934;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regulatory_change_radar-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regulatory_change_radar-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regulatory_change_radar-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regulatory_change_radar_iconbutton_button_1')]")
	private WebElement regulatoryChangeRadarIconbuttonButton1;

    public Clinic934RegulatorychangeradarscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic934RegulatorychangeradarscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic934RegulatorychangeradarscreenScreen", "/generated/regulatory-change-radar");
    }
}

