package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic663AichatbotscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 663;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ai_chatbot-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ai_chatbot-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ai_chatbot-content')]")
	private WebElement primaryContent;

    public Clinic663AichatbotscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic663AichatbotscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic663AichatbotscreenScreen", "/generated/ai-chatbot");
    }
}

