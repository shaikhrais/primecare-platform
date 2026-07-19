package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic969SimulationlabschedulerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 969;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'simulation_lab_scheduler-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'simulation_lab_scheduler-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'simulation_lab_scheduler-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'simulation_lab_scheduler_outlinedbutton_button_1')]")
	private WebElement simulationLabSchedulerOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'simulation_lab_scheduler_iconbutton_button_1')]")
	private WebElement simulationLabSchedulerIconbuttonButton1;

    public Clinic969SimulationlabschedulerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic969SimulationlabschedulerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic969SimulationlabschedulerscreenScreen", "/generated/simulation-lab-scheduler");
    }
}
