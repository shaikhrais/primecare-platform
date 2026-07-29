package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate487ExpensemanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 487;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expense_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expense_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expense_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-title')]")
	private WebElement expensemanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-loading')]")
	private WebElement expensemanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-screen')]")
	private WebElement expensemanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-btn-2')]")
	private WebElement expensemanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-btn-3')]")
	private WebElement expensemanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-btn-1')]")
	private WebElement expensemanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'expensemanagement-content')]")
	private WebElement expensemanagementContent;

    public Corporate487ExpensemanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate487ExpensemanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate487ExpensemanagementscreenScreen", "/executive/expense-management");
    }
}

