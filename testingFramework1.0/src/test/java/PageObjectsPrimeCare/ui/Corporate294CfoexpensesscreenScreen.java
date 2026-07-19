package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate294CfoexpensesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 294;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_expenses-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_expenses-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_expenses-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-title')]")
	private WebElement cfoexpensesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-loading')]")
	private WebElement cfoexpensesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-screen')]")
	private WebElement cfoexpensesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-btn-3')]")
	private WebElement cfoexpensesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-btn-2')]")
	private WebElement cfoexpensesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-btn-1')]")
	private WebElement cfoexpensesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoexpenses-content')]")
	private WebElement cfoexpensesContent;

    public Corporate294CfoexpensesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate294CfoexpensesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate294CfoexpensesscreenScreen", "/offices/corporate/roles/cfo/expenses");
    }
}
