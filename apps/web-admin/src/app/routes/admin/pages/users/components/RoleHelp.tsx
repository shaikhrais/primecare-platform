import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const RoleHelp: React.FC = () => {
    return (
        <div style={{ padding: '1.5rem', backgroundColor: '#fff7ed', borderRadius: '1rem', border: '1px solid #ffedd5', height: 'fit-content' }}>
            <h4 style={{ margin: '0 0 1rem 0', color: '#9a3412', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                {ContentRegistry.ROLE_HELP.TITLE}
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>
                        {ContentRegistry.ROLE_HELP.ADMIN.TITLE}
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>{ContentRegistry.ROLE_HELP.ADMIN.LABEL}</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>{ContentRegistry.ROLE_HELP.ADMIN.INFO}</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>
                        {ContentRegistry.ROLE_HELP.STAFF.TITLE}
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>{ContentRegistry.ROLE_HELP.STAFF.LABEL}</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>{ContentRegistry.ROLE_HELP.STAFF.INFO}</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>
                        {ContentRegistry.ROLE_HELP.MANAGER.TITLE}
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.8rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>{ContentRegistry.ROLE_HELP.MANAGER.LABEL}</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>{ContentRegistry.ROLE_HELP.MANAGER.INFO}</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>
                        {ContentRegistry.ROLE_HELP.PROVIDER.TITLE}
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>{ContentRegistry.ROLE_HELP.PROVIDER.LABEL}</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>{ContentRegistry.ROLE_HELP.PROVIDER.INFO}</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>
                        {ContentRegistry.ROLE_HELP.CLIENT.TITLE}
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>{ContentRegistry.ROLE_HELP.CLIENT.LABEL}</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>{ContentRegistry.ROLE_HELP.CLIENT.INFO}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div style={{ marginTop: '1.5rem', paddingTop: '1rem', borderTop: '1px solid #fed7aa', fontSize: '0.8rem', color: '#7c2d12' }}>
                <strong>{ContentRegistry.ROLE_HELP.TIP_LABEL}</strong> {ContentRegistry.ROLE_HELP.TIP_CONTENT}
            </div>
        </div>
    );
};
