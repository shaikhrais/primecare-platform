package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic832NoaccessscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 832;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'no_access-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'no_access-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'no_access-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'state_widgets_elevatedbutton_button_1')]")
	private WebElement stateWidgetsElevatedbuttonButton1;

    public Clinic832NoaccessscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic832NoaccessscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic832NoaccessscreenScreen", "/generated/no-access");
    }
}

