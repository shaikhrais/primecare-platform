package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic921FaqmanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 921;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'f_a_q_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'f_a_q_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'f_a_q_manager-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'faq_manager_screen_textbutton_button_2')]")
	private WebElement faqManagerScreenTextbuttonButton2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'faq_manager_screen_iconbutton_button_1')]")
	private WebElement faqManagerScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'faq_manager_screen_textbutton_button_1')]")
	private WebElement faqManagerScreenTextbuttonButton1;

    public Clinic921FaqmanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic921FaqmanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic921FaqmanagerscreenScreen", "/generated/f-a-q-manager");
    }
}
