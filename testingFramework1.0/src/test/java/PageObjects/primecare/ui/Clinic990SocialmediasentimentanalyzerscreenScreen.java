package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic990SocialmediasentimentanalyzerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 990;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media_sentiment_analyzer-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media_sentiment_analyzer-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media_sentiment_analyzer-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_media_sentiment_analyzer_iconbutton_button_1')]")
	private WebElement socialMediaSentimentAnalyzerIconbuttonButton1;

    public Clinic990SocialmediasentimentanalyzerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic990SocialmediasentimentanalyzerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic990SocialmediasentimentanalyzerscreenScreen", "/generated/social-media-sentiment-analyzer");
    }
}

