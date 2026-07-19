package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client524ConflictresolutionscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 524;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflict_resolution-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflict_resolution-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflict_resolution-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-btn-3')]")
	private WebElement conflictresolutionBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-btn-5')]")
	private WebElement conflictresolutionBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-btn-2')]")
	private WebElement conflictresolutionBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-title')]")
	private WebElement conflictresolutionTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-screen')]")
	private WebElement conflictresolutionScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-content')]")
	private WebElement conflictresolutionContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-btn-4')]")
	private WebElement conflictresolutionBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'conflictresolution-btn-1')]")
	private WebElement conflictresolutionBtn1;

    public Client524ConflictresolutionscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client524ConflictresolutionscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client524ConflictresolutionscreenScreen", "/staff/conflict-resolution");
    }
}
