package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic997VirtualconsultscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 997;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_consult-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_consult-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_consult-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'virtual_consult_screen_textfield_input_1')]")
	private WebElement virtualConsultScreenTextfieldInput1;

    public Clinic997VirtualconsultscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic997VirtualconsultscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic997VirtualconsultscreenScreen", "/generated/virtual-consult");
    }
}
