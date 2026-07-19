package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic352PhysiotherapistreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 352;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistreports-btn-2')]")
	private WebElement physiotherapistreportsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistreports-title')]")
	private WebElement physiotherapistreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistreports-content')]")
	private WebElement physiotherapistreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistreports-screen')]")
	private WebElement physiotherapistreportsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistreports-btn-3')]")
	private WebElement physiotherapistreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistreports-btn-1')]")
	private WebElement physiotherapistreportsBtn1;

    public Clinic352PhysiotherapistreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic352PhysiotherapistreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic352PhysiotherapistreportsscreenScreen", "/offices/clinical/roles/physiotherapist/reports");
    }
}
