package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client605Schedulingoperations4kscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 605;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_operations4_k-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_operations4_k-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_operations4_k-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-btn-2')]")
	private WebElement schedulingoperations4kBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-btn-3')]")
	private WebElement schedulingoperations4kBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-btn-4')]")
	private WebElement schedulingoperations4kBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-btn-5')]")
	private WebElement schedulingoperations4kBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-screen')]")
	private WebElement schedulingoperations4kScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-btn-1')]")
	private WebElement schedulingoperations4kBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-title')]")
	private WebElement schedulingoperations4kTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingoperations4k-content')]")
	private WebElement schedulingoperations4kContent;

    public Client605Schedulingoperations4kscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client605Schedulingoperations4kscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client605Schedulingoperations4kscreenScreen", "/staff/scheduling-operations4-k");
    }
}
