package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic680FamilymemberlovedoneschedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 680;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_loved_one_schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_loved_one_schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_loved_one_schedule-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberlovedoneschedulescreen-screen')]")
	private WebElement familymemberlovedoneschedulescreenScreen;

    public Clinic680FamilymemberlovedoneschedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic680FamilymemberlovedoneschedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic680FamilymemberlovedoneschedulescreenScreen", "/generated/family-member-loved-one-schedule");
    }
}

