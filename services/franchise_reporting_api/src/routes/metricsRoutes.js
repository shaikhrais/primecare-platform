
const express = require('express');
const router = express.Router();
const metricsController = require('../controllers/metricsController');

// Franchise metrics endpoints categorized by usage frequency
router.get('/daily', metricsController.getDailyMetrics);
router.get('/weekly', metricsController.getWeeklyReport);
router.get('/yearly/audit', metricsController.getAnnualAudit);

module.exports = router;
