package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic955StaffutilizationheatmapscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 955;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_utilization_heatmap-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_utilization_heatmap-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_utilization_heatmap-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'staff_utilization_heatmap_iconbutton_button_1')]")
	private WebElement staffUtilizationHeatmapIconbuttonButton1;

    public Clinic955StaffutilizationheatmapscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic955StaffutilizationheatmapscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic955StaffutilizationheatmapscreenScreen", "/generated/staff-utilization-heatmap");
    }
}

