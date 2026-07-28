package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic942SystemcapacityplannerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 942;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_capacity_planner-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_capacity_planner-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_capacity_planner-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_capacity_planner_iconbutton_button_1')]")
	private WebElement systemCapacityPlannerIconbuttonButton1;

    public Clinic942SystemcapacityplannerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic942SystemcapacityplannerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic942SystemcapacityplannerscreenScreen", "/generated/system-capacity-planner");
    }
}

