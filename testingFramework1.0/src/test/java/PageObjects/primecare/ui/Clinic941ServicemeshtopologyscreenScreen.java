package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic941ServicemeshtopologyscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 941;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_mesh_topology-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_mesh_topology-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_mesh_topology-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_mesh_topology_iconbutton_button_1')]")
	private WebElement serviceMeshTopologyIconbuttonButton1;

    public Clinic941ServicemeshtopologyscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic941ServicemeshtopologyscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic941ServicemeshtopologyscreenScreen", "/generated/service-mesh-topology");
    }
}

