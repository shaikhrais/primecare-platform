package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate606Financialoperations4kscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 606;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_operations4_k-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_operations4_k-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_operations4_k-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialoperations4k-btn-2')]")
	private WebElement financialoperations4kBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialoperations4k-btn-1')]")
	private WebElement financialoperations4kBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialoperations4k-content')]")
	private WebElement financialoperations4kContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialoperations4k-screen')]")
	private WebElement financialoperations4kScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialoperations4k-title')]")
	private WebElement financialoperations4kTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financialoperations4k-btn-3')]")
	private WebElement financialoperations4kBtn3;

    public Corporate606Financialoperations4kscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate606Financialoperations4kscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate606Financialoperations4kscreenScreen", "/executive/financial-operations4-k");
    }
}

