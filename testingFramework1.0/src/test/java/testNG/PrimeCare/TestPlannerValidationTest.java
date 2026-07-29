package testNG.PrimeCare;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import primecare.testing.base.BaseTest;
import primecare.testing.models.*;
import primecare.testing.framework.*;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.util.HashSet;
import java.util.Set;

public class TestPlannerValidationTest extends BaseTest {

    @Test(groups = {"unit", "planner"})
    public void testExactLevelResolution() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.executionMode = ExecutionMode.EXACT;
        req.level = 3;

        Set<TestingLayerCode> layers = LayerSelectionService.resolveLayers(req);
        Assert.assertEquals(layers.size(), 1);
        Assert.assertTrue(layers.contains(TestingLayerCode.L3));
    }

    @Test(groups = {"unit", "planner"})
    public void testUpToLevelResolution() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.executionMode = ExecutionMode.UP_TO;
        req.level = 3;

        Set<TestingLayerCode> layers = LayerSelectionService.resolveLayers(req);
        Assert.assertEquals(layers.size(), 3);
        Assert.assertTrue(layers.contains(TestingLayerCode.L1));
        Assert.assertTrue(layers.contains(TestingLayerCode.L2));
        Assert.assertTrue(layers.contains(TestingLayerCode.L3));
    }

    @Test(groups = {"unit", "planner"})
    public void testRangeLevelResolution() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.executionMode = ExecutionMode.RANGE;
        req.fromLevel = 3;
        req.toLevel = 5;

        Set<TestingLayerCode> layers = LayerSelectionService.resolveLayers(req);
        Assert.assertEquals(layers.size(), 3);
        Assert.assertTrue(layers.contains(TestingLayerCode.L3));
        Assert.assertTrue(layers.contains(TestingLayerCode.L4));
        Assert.assertTrue(layers.contains(TestingLayerCode.L5));
    }

    @Test(groups = {"unit", "planner"})
    public void testSelectedLayersResolution() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.executionMode = ExecutionMode.SELECTED;
        req.selectedLayers = new HashSet<>();
        req.selectedLayers.add(TestingLayerCode.L2);
        req.selectedLayers.add(TestingLayerCode.L5);

        Set<TestingLayerCode> layers = LayerSelectionService.resolveLayers(req);
        Assert.assertEquals(layers.size(), 2);
        Assert.assertTrue(layers.contains(TestingLayerCode.L2));
        Assert.assertTrue(layers.contains(TestingLayerCode.L5));
    }

    @Test(expectedExceptions = IllegalArgumentException.class, groups = {"unit", "planner"})
    public void testInvalidLevelFailsValidation() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.level = 11;
        TestExecutionRequestValidator.validate(req);
    }

    @Test(expectedExceptions = IllegalArgumentException.class, groups = {"unit", "planner"})
    public void testInvalidRangeFailsValidation() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.executionMode = ExecutionMode.RANGE;
        req.fromLevel = 5;
        req.toLevel = 3;
        TestExecutionRequestValidator.validate(req);
    }

    @Test(groups = {"unit", "planner"})
    public void testDependencyExpansion() {
        Set<TestingLayerCode> targets = new HashSet<>();
        targets.add(TestingLayerCode.L3);

        Set<TestingLayerCode> expanded = DependencyExpansionService.expandDependencies(targets, true);
        Assert.assertEquals(expanded.size(), 3);
        Assert.assertTrue(expanded.contains(TestingLayerCode.L1));
        Assert.assertTrue(expanded.contains(TestingLayerCode.L2));
        Assert.assertTrue(expanded.contains(TestingLayerCode.L3));
    }

    @Test(groups = {"unit", "planner"})
    public void testNoDependencyExpansion() {
        Set<TestingLayerCode> targets = new HashSet<>();
        targets.add(TestingLayerCode.L3);

        Set<TestingLayerCode> expanded = DependencyExpansionService.expandDependencies(targets, false);
        Assert.assertEquals(expanded.size(), 1);
        Assert.assertTrue(expanded.contains(TestingLayerCode.L3));
    }

    @Test(groups = {"integration", "planner"})
    public void testPlanCreationAndPersistence() {
        TestExecutionRequest req = new TestExecutionRequest();
        req.screenKey = "login";
        req.executionMode = ExecutionMode.UP_TO;
        req.level = 2;
        req.includeDependencies = true;

        TestPlan plan = TestPlanFactory.createPlan(req);
        Assert.assertNotNull(plan.planUuid);
        Assert.assertTrue(plan.items.size() >= 2);
    }
}

