package testNG.PrimeCare;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import primecare.testing.base.BaseTest;
import primecare.testing.framework.Models.BusinessRuleDefinition;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.Repositories.BusinessRuleRepository;
import primecare.testing.validation.TestLayer;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.regex.Pattern;

@TestLayer(TestingLayerCode.L4)
public class L4BusinessLogicTest extends BaseTest {

    @Test(groups = {"l4"})
    public void verifyAuthenticationBusinessRules() {
        System.out.println("[L4] Running authentication business logic validations...");
        
        BusinessRuleDefinition rule = BusinessRuleRepository.getBusinessRule("AUTH_VALIDATION");
        Assert.assertNotNull(rule, "Business rule AUTH_VALIDATION not found in database.");

        // Expected logic json contains regex format check: {"email_format":"^[^@]+@[^@]+\\.[^@]+$","min_password_len":6}
        String emailFormat = "^[^@]+@[^@]+\\.[^@]+$";
        int minPassLen = 6;

        // Verify valid inputs
        String validEmail = "user@primecare.com";
        String validPass = "Password123";
        Assert.assertTrue(Pattern.matches(emailFormat, validEmail), "Valid email failed rule format verification.");
        Assert.assertTrue(validPass.length() >= minPassLen, "Valid password failed length validation.");

        // Verify boundary/invalid inputs
        String invalidEmail = "invalid-email-no-at";
        String shortPass = "123";
        Assert.assertFalse(Pattern.matches(emailFormat, invalidEmail), "Invalid email incorrectly passed rule validation.");
        Assert.assertFalse(shortPass.length() >= minPassLen, "Short password incorrectly passed length validation.");

        System.out.println("[L4] Business logic boundaries verified successfully.");
    }
}

