package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client77HrhiringdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 77;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_textfield_input_1')]")
	private WebElement hrHiringDashboardTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_textbutton_button_1')]")
	private WebElement hrHiringDashboardTextbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_textfield_input_2')]")
	private WebElement hrHiringDashboardTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_elevatedbutton_button_4')]")
	private WebElement hrHiringDashboardElevatedbuttonButton4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_elevatedbutton_button_3')]")
	private WebElement hrHiringDashboardElevatedbuttonButton3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_textfield_input_3')]")
	private WebElement hrHiringDashboardTextfieldInput3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_elevatedbutton_button_1')]")
	private WebElement hrHiringDashboardElevatedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_elevatedbutton_button_2')]")
	private WebElement hrHiringDashboardElevatedbuttonButton2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_dashboard_textbutton_button_2')]")
	private WebElement hrHiringDashboardTextbuttonButton2;

    public Client77HrhiringdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client77HrhiringdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client77HrhiringdashboardscreenScreen", "/offices/corporate/roles/hr_hiring/dashboard");
    }
}

