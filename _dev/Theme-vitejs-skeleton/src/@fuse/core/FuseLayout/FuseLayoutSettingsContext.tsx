// Associated data Provider mapped for ViewModel
// Structural UI Theme and Styles layout binding
// Core presentation build Widget logic
import { createContext } from 'react';
import { FuseSettingsConfigType } from '@fuse/core/FuseSettings/FuseSettings';

type FuseLayoutSettingsContextType = FuseSettingsConfigType['layout'];

const FuseLayoutSettingsContext = createContext<FuseLayoutSettingsContextType | undefined>(undefined);

export default FuseLayoutSettingsContext;
