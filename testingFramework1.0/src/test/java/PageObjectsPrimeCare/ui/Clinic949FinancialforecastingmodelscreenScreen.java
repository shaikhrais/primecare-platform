package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic949FinancialforecastingmodelscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 949;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_forecasting_model-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_forecasting_model-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_forecasting_model-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financial_forecasting_model_iconbutton_button_1')]")
	private WebElement financialForecastingModelIconbuttonButton1;

    public Clinic949FinancialforecastingmodelscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic949FinancialforecastingmodelscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic949FinancialforecastingmodelscreenScreen", "/generated/financial-forecasting-model");
    }
}
