package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic995ServiceprocurementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 995;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement_screen_outlinedbutton_button_1')]")
	private WebElement serviceProcurementScreenOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement_screen_textfield_input_2')]")
	private WebElement serviceProcurementScreenTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement_screen_elevatedbutton_button_1')]")
	private WebElement serviceProcurementScreenElevatedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_procurement_screen_textfield_input_1')]")
	private WebElement serviceProcurementScreenTextfieldInput1;

    public Clinic995ServiceprocurementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic995ServiceprocurementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic995ServiceprocurementscreenScreen", "/generated/service-procurement");
    }
}
