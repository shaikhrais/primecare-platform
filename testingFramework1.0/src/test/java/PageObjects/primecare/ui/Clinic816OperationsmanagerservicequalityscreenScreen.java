package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic816OperationsmanagerservicequalityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 816;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_service_quality-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_service_quality-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_service_quality-content')]")
	private WebElement primaryContent;

    public Clinic816OperationsmanagerservicequalityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic816OperationsmanagerservicequalityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic816OperationsmanagerservicequalityscreenScreen", "/offices/franchise/roles/operations_manager/service-quality");
    }
}

