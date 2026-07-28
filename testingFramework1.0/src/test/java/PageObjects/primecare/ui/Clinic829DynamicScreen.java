package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic829DynamicScreen extends baseTest {
 
    public static final int SCREEN_ID = 829;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_screen_view_iconbutton_button_1')]")
	private WebElement dynamicScreenViewIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_screen_view_textfield_input_1')]")
	private WebElement dynamicScreenViewTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_screen_view_textbutton_button_1')]")
	private WebElement dynamicScreenViewTextbuttonButton1;

    public Clinic829DynamicScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic829DynamicScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic829DynamicScreen", "/generated/dynamic");
    }
}

