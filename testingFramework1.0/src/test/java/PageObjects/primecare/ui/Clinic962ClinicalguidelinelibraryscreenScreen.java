package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic962ClinicalguidelinelibraryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 962;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_guideline_library-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_guideline_library-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_guideline_library-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_guideline_library_outlinedbutton_button_1')]")
	private WebElement clinicalGuidelineLibraryOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_guideline_library_iconbutton_button_1')]")
	private WebElement clinicalGuidelineLibraryIconbuttonButton1;

    public Clinic962ClinicalguidelinelibraryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic962ClinicalguidelinelibraryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic962ClinicalguidelinelibraryscreenScreen", "/generated/clinical-guideline-library");
    }
}

