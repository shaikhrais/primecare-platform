package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client521ServiceissuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 521;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_issue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_issue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'service_issue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-btn-3')]")
	private WebElement serviceissueBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-btn-1')]")
	private WebElement serviceissueBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-screen')]")
	private WebElement serviceissueScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-title')]")
	private WebElement serviceissueTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-loading')]")
	private WebElement serviceissueLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-content')]")
	private WebElement serviceissueContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'serviceissue-btn-2')]")
	private WebElement serviceissueBtn2;

    public Client521ServiceissuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client521ServiceissuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client521ServiceissuescreenScreen", "/management/service-issue");
    }
}
