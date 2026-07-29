package primecare.testing.framework;

public class TestExecutionRequestValidator {

    public static void validate(TestExecutionRequest request) {
        if (request.level != null && (request.level < 1 || request.level > 10)) {
            throw new IllegalArgumentException("Validation Error: level must be between 1 and 10.");
        }

        if (request.fromLevel != null && (request.fromLevel < 1 || request.fromLevel > 10)) {
            throw new IllegalArgumentException("Validation Error: fromLevel must be between 1 and 10.");
        }

        if (request.toLevel != null && (request.toLevel < 1 || request.toLevel > 10)) {
            throw new IllegalArgumentException("Validation Error: toLevel must be between 1 and 10.");
        }

        if (request.fromLevel != null && request.toLevel != null && request.fromLevel > request.toLevel) {
            throw new IllegalArgumentException("Validation Error: fromLevel cannot be greater than toLevel.");
        }

        if (request.executionMode == ExecutionMode.SELECTED && (request.selectedLayers == null || request.selectedLayers.isEmpty())) {
            throw new IllegalArgumentException("Validation Error: SELECTED mode requires layers property to be specified.");
        }

        if (request.executionMode == ExecutionMode.RANGE && (request.fromLevel == null || request.toLevel == null)) {
            throw new IllegalArgumentException("Validation Error: RANGE mode requires fromLevel and toLevel to be specified.");
        }

        if ((request.executionMode == ExecutionMode.EXACT || request.executionMode == ExecutionMode.UP_TO) && request.level == null) {
            throw new IllegalArgumentException("Validation Error: EXACT and UP_TO modes require level to be specified.");
        }

        System.out.println("[VALIDATION] TestExecutionRequest is valid.");
    }
}

