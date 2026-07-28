package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic998ChemotherapyprotocolbuilderscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 998;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chemotherapy_protocol_builder-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chemotherapy_protocol_builder-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chemotherapy_protocol_builder-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol-search')]")
	private WebElement protocolSearch;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol-btn-publish')]")
	private WebElement protocolBtnPublish;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol-btn-pdf')]")
	private WebElement protocolBtnPdf;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol-btn-create')]")
	private WebElement protocolBtnCreate;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol-btn-save-draft')]")
	private WebElement protocolBtnSaveDraft;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol-dosage-field')]")
	private WebElement protocolDosageField;

    public Clinic998ChemotherapyprotocolbuilderscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic998ChemotherapyprotocolbuilderscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic998ChemotherapyprotocolbuilderscreenScreen", "/generated/chemotherapy-protocol-builder");
    }
}

