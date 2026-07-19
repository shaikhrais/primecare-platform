package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client556AdjustmentnotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 556;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustment_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustment_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustment_notes-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-btn-1')]")
	private WebElement adjustmentnotesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-screen')]")
	private WebElement adjustmentnotesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-content')]")
	private WebElement adjustmentnotesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-btn-2')]")
	private WebElement adjustmentnotesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-loading')]")
	private WebElement adjustmentnotesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-btn-3')]")
	private WebElement adjustmentnotesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adjustmentnotes-title')]")
	private WebElement adjustmentnotesTitle;

    public Client556AdjustmentnotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client556AdjustmentnotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client556AdjustmentnotesscreenScreen", "/offices/clinical/roles/chiropractor/adjustment-notes");
    }
}
