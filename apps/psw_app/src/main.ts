import './style.css'

document.querySelectorAll('.checkbox').forEach(cb => {
  cb.addEventListener('click', () => {
    cb.classList.toggle('checked');
    
    // Simulate haptic feedback
    if ('vibrate' in navigator) {
      navigator.vibrate(20);
    }
  });
});

const modal = document.getElementById('report-modal');
const reportBtn = document.getElementById('report-btn');
const closeBtn = document.getElementById('close-modal');

if (reportBtn && modal) {
  reportBtn.addEventListener('click', () => {
    modal.style.display = 'flex';
  });
}

if (closeBtn && modal) {
  closeBtn.addEventListener('click', () => {
    modal.style.display = 'none';
  });
}

// Close on overlay click
window.onclick = (event) => {
  if (event.target == modal!) {
    modal!.style.display = 'none';
  }
}

console.log('PrimeCare PSW App Initialized');
