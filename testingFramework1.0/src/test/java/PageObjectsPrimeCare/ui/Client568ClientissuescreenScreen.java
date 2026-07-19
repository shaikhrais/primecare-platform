package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client568ClientissuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 568;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_issue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_issue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_issue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-screen')]")
	private WebElement clientissueScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-btn-5')]")
	private WebElement clientissueBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-loading')]")
	private WebElement clientissueLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-title')]")
	private WebElement clientissueTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-content')]")
	private WebElement clientissueContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-btn-4')]")
	private WebElement clientissueBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-btn-3')]")
	private WebElement clientissueBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-btn-1')]")
	private WebElement clientissueBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientissue-btn-2')]")
	private WebElement clientissueBtn2;

    public Client568ClientissuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client568ClientissuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client568ClientissuescreenScreen", "/staff/client-issue");
    }
}
