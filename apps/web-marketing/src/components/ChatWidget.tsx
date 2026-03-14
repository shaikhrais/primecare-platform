import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';
import { useChatLogic, ContactFormView, MenuView, ChatView, CallView } from './ChatWidgetParts';

const { RouteRegistry } = MarketingRegistry;

export default function ChatWidget() {
    const chat = useChatLogic();
    return (
        <div style={{ position: 'fixed', bottom: '2rem', right: '2rem', zIndex: 9999 }}>
            {chat.isOpen && (
                <div style={{ position: 'absolute', bottom: '70px', right: 0, width: 'min(360px, calc(100vw - 4rem))', height: chat.view === 'chat' ? '500px' : 'auto', backgroundColor: 'white', borderRadius: '16px', boxShadow: '0 10px 40px rgba(0,0,0,0.2)', overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
                    <div style={{ backgroundColor: '#00897b', color: 'white', padding: '1rem 1.25rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div>
                            <h3 style={{ fontSize: '1.1rem', margin: 0 }}>{chat.view === 'menu' && 'How can we help?'}{chat.view === 'contact' && '📋 Your Details'}{chat.view === 'chat' && '💬 AI Chat'}{chat.view === 'call' && '📞 AI Voice Call'}</h3>
                            <p style={{ fontSize: '0.8rem', opacity: 0.9, margin: '0.25rem 0 0 0' }}>{chat.view === 'menu' && 'Choose an option below'}{chat.view === 'contact' && 'We need your info to proceed'}{chat.view === 'chat' && 'Chat with our AI assistant'}{chat.view === 'call' && (chat.isCallActive ? 'Call in progress' : 'Speak with our AI agent')}</p>
                        </div>
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            {chat.view !== 'menu' && chat.view !== 'contact' && <button onClick={() => chat.setView('menu')} data-cy="btn-chat-back" style={{ background: 'none', border: 'none', color: 'white', fontSize: '1rem', cursor: 'pointer' }}>←</button>}
                            <button onClick={() => chat.setIsOpen(false)} data-cy="btn-chat-close" style={{ background: 'none', border: 'none', color: 'white', fontSize: '1.25rem', cursor: 'pointer' }}>✕</button>
                        </div>
                    </div>
                    {chat.view === 'contact' && <ContactFormView contactInfo={chat.contactInfo} setContactInfo={chat.setContactInfo} handleContactSubmit={chat.handleContactSubmit} />}
                    {chat.view === 'menu' && <MenuView startAction={chat.startAction} getWhatsAppUrl={chat.getWhatsAppUrl} />}
                    {chat.view === 'chat' && <ChatView messages={chat.messages} isLoading={chat.isLoading} inputText={chat.inputText} setInputText={chat.setInputText} sendMessage={chat.sendMessage} messagesEndRef={chat.messagesEndRef} />}
                    {chat.view === 'call' && <CallView contactInfo={chat.contactInfo} isCallActive={chat.isCallActive} callStatus={chat.callStatus} startCall={chat.startCall} endCall={chat.endCall} />}
                    {chat.view === 'menu' && <div style={{ padding: '0.75rem', borderTop: '1px solid #eee', textAlign: 'center' }}><Link to={RouteRegistry.CONTACT} data-cy="lnk-chat-contact-page" onClick={() => chat.setIsOpen(false)} style={{ color: '#00897b', textDecoration: 'none', fontWeight: 'bold', fontSize: '0.85rem' }}>Or visit our Contact Page →</Link></div>}
                </div>
            )}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                {chat.showTooltip && !chat.isOpen && <div style={{ backgroundColor: 'white', padding: '0.75rem 1rem', borderRadius: '50px', boxShadow: '0 4px 15px rgba(0,0,0,0.15)', fontSize: '0.9rem', color: '#333' }}>Chat with us 👋</div>}
                <button onClick={chat.handleChat} data-cy="btn-chat-widget-toggle" style={{ width: '56px', height: '56px', borderRadius: '50%', backgroundColor: chat.isOpen ? '#333' : '#f59e0b', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', boxShadow: '0 4px 15px rgba(0,0,0,0.2)', transition: 'transform 0.2s' }} onMouseOver={(e) => e.currentTarget.style.transform = 'scale(1.1)'} onMouseOut={(e) => e.currentTarget.style.transform = 'scale(1)'}><span style={{ fontSize: '1.5rem' }}>{chat.isOpen ? '✕' : '💬'}</span></button>
            </div>
        </div>
    );
}
