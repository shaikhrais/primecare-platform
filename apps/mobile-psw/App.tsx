import React from 'react';
import { StyleSheet, useColorScheme } from 'react-native';
import { Colors } from 'react-native/Libraries/NewAppScreen';
import ErrorBoundary from './src/components/ErrorBoundary';
import AppNavigator from './src/navigation/AppNavigator';

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  return (
    <ErrorBoundary>
      <AppNavigator />
    </ErrorBoundary>
  );
}

const styles = StyleSheet.create({});

export default App;
