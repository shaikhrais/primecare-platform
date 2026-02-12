import { BrowserRouter } from 'react-router-dom';
import { AppRouter } from './app/router';
import { NotificationProvider, useNotification } from './shared/context/NotificationContext';
import CookieConsent from './shared/components/ui/CookieConsent';

export { useNotification };

function App() {
  return (
    <NotificationProvider>
      <CookieConsent />
      <BrowserRouter>
        <AppRouter />
      </BrowserRouter>
    </NotificationProvider>
  );
}

export default App;
