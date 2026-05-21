const fs = require('fs');
const path = require('path');

const UI_PACKAGE_PATH = path.join(__dirname, '..', 'packages', 'primecare_ui', 'lib', 'src', 'screens');
const PREMIUM_DIR = path.join(UI_PACKAGE_PATH, 'premium');

if (!fs.existsSync(PREMIUM_DIR)) {
  console.log('Premium directory not found at:', PREMIUM_DIR);
  process.exit(1);
}

// Define Roles and their features by frequency
const roles = {
  employee: {
    daily: ['daily_tasks', 'shift_schedule', 'patient_vitals_entry', 'messages', 'medication_log'],
    weekly: ['weekly_timesheet', 'department_meeting_notes', 'inventory_check', 'performance_summary'],
    monthly: ['monthly_training_modules', 'pay_stub_view', 'compliance_checklist'],
    yearly: ['annual_review', 'benefits_enrollment', 'certification_renewal']
  },
  client: {
    daily: ['health_feed', 'daily_goals', 'appointment_reminder', 'diet_tracker'],
    weekly: ['weekly_health_summary', 'telehealth_consult', 'prescription_refill'],
    monthly: ['billing_statement', 'lab_results_history', 'care_plan_update'],
    yearly: ['annual_wellness_visit', 'insurance_update', 'tax_documents']
  }
};

let featureCounter = 1;
const mappings = [];

// Helper to convert snake_case to PascalCase
const toPascalCase = (str) => {
  return str.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('');
};

function processScreens() {
  const newBaseDir = path.join(UI_PACKAGE_PATH, 'roles');
  if (!fs.existsSync(newBaseDir)) fs.mkdirSync(newBaseDir, { recursive: true });

  for (const [role, frequencies] of Object.entries(roles)) {
    const roleDir = path.join(newBaseDir, role);
    if (!fs.existsSync(roleDir)) fs.mkdirSync(roleDir);

    for (const [freq, features] of Object.entries(frequencies)) {
      const freqDir = path.join(roleDir, freq);
      if (!fs.existsSync(freqDir)) fs.mkdirSync(freqDir);

      for (const feature of features) {
        // Look for existing premium feature
        const oldFeatureDirName = `premium_feature_${featureCounter}`;
        const oldFeatureDir = path.join(PREMIUM_DIR, oldFeatureDirName);
        
        if (fs.existsSync(oldFeatureDir)) {
          const newFeatureDir = path.join(freqDir, feature);
          if (!fs.existsSync(newFeatureDir)) fs.mkdirSync(newFeatureDir);

          // Get all dart files in the old directory
          const files = fs.readdirSync(oldFeatureDir).filter(f => f.endsWith('.dart'));
          for (const file of files) {
            const oldFilePath = path.join(oldFeatureDir, file);
            let newFileName = file.replace(`premium_feature_${featureCounter}`, feature);
            const newFilePath = path.join(newFeatureDir, newFileName);
            
            let content = fs.readFileSync(oldFilePath, 'utf8');
            
            // Replace Class names
            const oldClassName = `PremiumFeature${featureCounter}`;
            const newClassName = toPascalCase(feature);
            content = content.replace(new RegExp(oldClassName, 'g'), newClassName);
            
            // Replace screen IDs
            content = content.replace(new RegExp(`SCREEN_PREMIUM_FEATURE_${featureCounter}`, 'g'), `SCREEN_${role.toUpperCase()}_${feature.toUpperCase()}`);
            
            fs.writeFileSync(newFilePath, content);
          }
          console.log(`Migrated ${oldFeatureDirName} to ${role}/${freq}/${feature}`);
          mappings.push({ old: oldFeatureDirName, new: `${role}/${freq}/${feature}` });
          featureCounter++;
        }
      }
    }
  }
  
  // Cleanup old directory
  console.log(`Processed ${featureCounter - 1} screens. Remaining premium screens can be cleaned up.`);
}

processScreens();
