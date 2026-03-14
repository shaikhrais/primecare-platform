/**
 * ChatWidget Sub-Components
 * Extracted from ChatWidget.tsx — Views + Logic
 */
import React, { useState, useRef, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { RouteRegistry } = MarketingRegistry;
const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

export interface Message { id: string; text: string; sender: 'user' | 'ai'; timestamp: Date; }
export interface ContactInfo { name: string; phone: string; email: string; }

export function useChatLogic() {
    const [isOpen, setIsOpen] = useState(false);
    const [showTooltip, setShowTooltip] = useState(true);
    const [view, setView] = useState<'menu' | 'contact' | 'chat' | 'call'>('menu');
    const [contactInfo, setContactInfo] = useState<ContactInfo>({ name: '', phone: '', email: '' });
    const [contactSubmitted, setContactSubmitted] = useState(false);
    const [messages, setMessages] = useState<Message[]>([]);
    const [inputText, setInputText] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [isCallActive, setIsCallActive] = useState(false);
    const [callStatus, setCallStatus] = useState('');
    const messagesEndRef = useRef<HTMLDivElement>(null);

    useEffect(() => { messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' }); }, [messages]);

    const handleChat = () => { setIsOpen(!isOpen); setShowTooltip(false); if (!isOpen) setView(contactSubmitted ? 'menu' : 'contact'); };
    const handleContactSubmit = async () => {
        if (!contactInfo.name || !contactInfo.phone || !contactInfo.email) return;
        try { await fetch(`${API_URL}/leads`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ full_name: contactInfo.name, email: contactInfo.email, phone: contactInfo.phone, message: "Started chat widget session", source: 'contact_form' }) }); } catch (e) { console.log('Lead save error', e); }
        setContactSubmitted(true); setView('menu');
    };
    const startAction = (action: 'chat' | 'call') => {
        setView(action);
        if (action === 'chat' && messages.length === 0) setMessages([{ id: '1', text: `Hi ${contactInfo.name}! I'm PrimeCare's AI assistant. How can I help you today?`, sender: 'ai', timestamp: new Date() }]);
    };
    const getWhatsAppUrl = () => `https://wa.me/14165551234?text=${encodeURIComponent(`Name: ${contactInfo.name}\nContact: ${contactInfo.phone}\nEmail: ${contactInfo.email}\n\nHow can I help you?`)}`;
    const sendMessage = async () => {
        if (!inputText.trim()) return;
        setMessages(prev => [...prev, { id: Date.now().toString(), text: inputText, sender: 'user', timestamp: new Date() }]); setInputText(''); setIsLoading(true);
        try {
            await new Promise(resolve => setTimeout(resolve, 1000));
            let aiResponse = `Thank you ${contactInfo.name}. One of our care coordinators will get back to you at ${contactInfo.phone}. Is there anything specific I can help you with?`;
            const lowerText = inputText.toLowerCase();
            if (lowerText.includes('price') || lowerText.includes('cost') || lowerText.includes('rate')) aiResponse = "Our rates vary based on service type. PSW home care starts at $28/hour. Foot care assessments are $75. Would you like me to have someone call you with a detailed quote?";
            else if (lowerText.includes('book') || lowerText.includes('appointment')) aiResponse = `I'd be happy to help you book an appointment! I'll have our team call you at ${contactInfo.phone}. What service are you interested in?`;
            else if (lowerText.includes('foot care') || lowerText.includes('diabetic')) aiResponse = "Our Foot Care Nurses specialize in diabetic foot care, nail care, and callus treatment. We offer home visits and facility services. Would you like to schedule an assessment?";
            else if (lowerText.includes('psw') || lowerText.includes('personal support')) aiResponse = "Our Personal Support Workers provide bathing assistance, meal prep, mobility support, and companionship. We offer flexible scheduling from 4 hours to 24/7 care.";
            setMessages(prev => [...prev, { id: (Date.now() + 1).toString(), text: aiResponse, sender: 'ai', timestamp: new Date() }]);
        } catch (error) { console.error('Chat error:', error); } finally { setIsLoading(false); }
    };
    const startCall = async () => { setIsCallActive(true); setCallStatus('Connecting to AI Agent...'); try { await new Promise(resolve => setTimeout(resolve, 2000)); setCallStatus('Connected! Speak now...'); setTimeout(() => setCallStatus(`AI: Hello ${contactInfo.name}! Welcome to PrimeCare. How can I assist you today?`), 3000); } catch (error) { setCallStatus('Connection failed. Please try again.'); } };
    const endCall = () => { setIsCallActive(false); setCallStatus(''); setView('menu'); };

    return { isOpen, setIsOpen, showTooltip, view, setView, contactInfo, setContactInfo, contactSubmitted, messages, inputText, setInputText, isLoading, isCallActive, callStatus, messagesEndRef, handleChat, handleContactSubmit, startAction, getWhatsAppUrl, sendMessage, startCall, endCall };
}

export function ContactFormView({ contactInfo, setContactInfo, handleContactSubmit }: { contactInfo: ContactInfo; setContactInfo: (c: ContactInfo) => void; handleContactSubmit: () => void }) {
    const inputStyle = { width: '100%', padding: '0.75rem', marginBottom: '0.75rem', borderRadius: '8px', border: '1px solid #ddd', fontSize: '0.9rem', boxSizing: 'border-box' as const };
    return (
        <div style={{ padding: '1.5rem' }}>
            <p style={{ color: '#666', fontSize: '0.9rem', marginBottom: '1rem' }}>Please share your details to explore our support options.</p>
            <input type="text" data-cy="chat-contact-name" placeholder="Your Name *" value={contactInfo.name} onChange={(e) => setContactInfo({ ...contactInfo, name: e.target.value })} style={inputStyle} />
            <input type="tel" data-cy="chat-contact-phone" placeholder="Phone Number *" value={contactInfo.phone} onChange={(e) => setContactInfo({ ...contactInfo, phone: e.target.value })} style={inputStyle} />
            <input type="email" data-cy="chat-contact-email" placeholder="Email Address *" value={contactInfo.email} onChange={(e) => setContactInfo({ ...contactInfo, email: e.target.value })} style={{ ...inputStyle, marginBottom: '1rem' }} />
            <button onClick={handleContactSubmit} data-cy="btn-chat-contact-submit" disabled={!contactInfo.name || !contactInfo.phone || !contactInfo.email} style={{ width: '100%', padding: '1rem', backgroundColor: '#00897b', color: 'white', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 'bold', opacity: (!contactInfo.name || !contactInfo.phone || !contactInfo.email) ? 0.5 : 1 }}>Continue →</button>
            <p style={{ color: '#999', fontSize: '0.75rem', marginTop: '0.75rem', textAlign: 'center' }}>We respect your privacy. Your info is used only to assist you.</p>
        </div>
    );
}

export function MenuView({ startAction, getWhatsAppUrl }: { startAction: (a: 'chat' | 'call') => void; getWhatsAppUrl: () => string }) {
    return (
        <div style={{ padding: '1rem' }}>
            <button onClick={() => startAction('chat')} data-cy="btn-chat-text" style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', width: '100%', backgroundColor: '#e8f5e9', borderRadius: '12px', border: 'none', cursor: 'pointer', marginBottom: '0.75rem', textAlign: 'left' }}><span style={{ fontSize: '2rem' }}>💬</span><div><div style={{ fontWeight: 'bold', color: '#00897b' }}>AI Text Chat</div><div style={{ fontSize: '0.85rem', color: '#666' }}>Chat with our AI assistant</div></div></button>
            <button onClick={() => startAction('call')} data-cy="btn-chat-voice" style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', width: '100%', backgroundColor: '#e3f2fd', borderRadius: '12px', border: 'none', cursor: 'pointer', marginBottom: '0.75rem', textAlign: 'left' }}><span style={{ fontSize: '2rem' }}>🎙️</span><div><div style={{ fontWeight: 'bold', color: '#1976d2' }}>AI Voice Call</div><div style={{ fontSize: '0.85rem', color: '#666' }}>Speak with our AI agent</div></div></button>
            <div style={{ borderTop: '1px solid #eee', paddingTop: '1rem', marginTop: '0.5rem' }}>
                <p style={{ color: '#999', fontSize: '0.8rem', marginBottom: '0.75rem', textAlign: 'center' }}>Or contact us directly:</p>
                <div style={{ display: 'flex', gap: '0.5rem' }}>
                    <a href="tel:+14165551234" data-cy="lnk-chat-call-direct" style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', padding: '0.75rem', backgroundColor: '#f8f9fa', borderRadius: '8px', textDecoration: 'none', color: '#333', fontSize: '0.85rem' }}>📞 Call</a>
                    <a href={getWhatsAppUrl()} data-cy="lnk-chat-whatsapp" target="_blank" rel="noopener noreferrer" style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', padding: '0.75rem', backgroundColor: '#25D366', borderRadius: '8px', textDecoration: 'none', color: 'white', fontSize: '0.85rem' }}>💬 WhatsApp</a>
                    <a href="mailto:info@primecare.ca" data-cy="lnk-chat-email-direct" style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', padding: '0.75rem', backgroundColor: '#f8f9fa', borderRadius: '8px', textDecoration: 'none', color: '#333', fontSize: '0.85rem' }}>✉️ Email</a>
                </div>
            </div>
        </div>
    );
}

export function ChatView({ messages, isLoading, inputText, setInputText, sendMessage, messagesEndRef }: { messages: Message[]; isLoading: boolean; inputText: string; setInputText: (t: string) => void; sendMessage: () => void; messagesEndRef: React.RefObject<HTMLDivElement> }) {
    return (
        <>
            <div style={{ flex: 1, overflowY: 'auto', padding: '1rem', backgroundColor: '#f8f9fa' }}>
                {messages.map(msg => (
                    <div key={msg.id} style={{ display: 'flex', justifyContent: msg.sender === 'user' ? 'flex-end' : 'flex-start', marginBottom: '0.75rem' }}>
                        <div style={{ maxWidth: '80%', padding: '0.75rem 1rem', borderRadius: msg.sender === 'user' ? '16px 16px 4px 16px' : '16px 16px 16px 4px', backgroundColor: msg.sender === 'user' ? '#00897b' : 'white', color: msg.sender === 'user' ? 'white' : '#333', boxShadow: '0 1px 2px rgba(0,0,0,0.1)' }}>{msg.text}</div>
                    </div>
                ))}
                {isLoading && <div style={{ display: 'flex', justifyContent: 'flex-start', marginBottom: '0.75rem' }}><div style={{ padding: '0.75rem 1rem', backgroundColor: 'white', borderRadius: '16px', boxShadow: '0 1px 2px rgba(0,0,0,0.1)' }}>Typing...</div></div>}
                <div ref={messagesEndRef} />
            </div>
            <div style={{ padding: '1rem', borderTop: '1px solid #eee', display: 'flex', gap: '0.5rem' }}>
                <input type="text" data-cy="chat-input-text" value={inputText} onChange={(e) => setInputText(e.target.value)} onKeyPress={(e) => e.key === 'Enter' && sendMessage()} placeholder="Type your message..." style={{ flex: 1, padding: '0.75rem', borderRadius: '24px', border: '1px solid #ddd', outline: 'none', fontSize: '0.9rem' }} />
                <button onClick={sendMessage} data-cy="btn-chat-send" disabled={isLoading || !inputText.trim()} style={{ padding: '0.75rem 1rem', backgroundColor: '#00897b', color: 'white', border: 'none', borderRadius: '24px', cursor: 'pointer', opacity: isLoading || !inputText.trim() ? 0.5 : 1 }}>Send</button>
            </div>
        </>
    );
}

export function CallView({ contactInfo, isCallActive, callStatus, startCall, endCall }: { contactInfo: ContactInfo; isCallActive: boolean; callStatus: string; startCall: () => void; endCall: () => void }) {
    return (
        <div style={{ padding: '2rem', textAlign: 'center' }}>
            {!isCallActive ? (
                <><div style={{ fontSize: '4rem', marginBottom: '1rem' }}>🎙️</div><h4 style={{ margin: '0 0 0.5rem 0', color: '#333' }}>AI Voice Assistant</h4><p style={{ color: '#666', fontSize: '0.9rem', marginBottom: '1.5rem' }}>Ready to help you, {contactInfo.name}</p><button onClick={startCall} data-cy="btn-chat-call-start" style={{ padding: '1rem 2rem', backgroundColor: '#00897b', color: 'white', border: 'none', borderRadius: '50px', cursor: 'pointer', fontSize: '1rem', fontWeight: 'bold' }}>🎤 Start Voice Call</button></>
            ) : (
                <><div style={{ width: '100px', height: '100px', borderRadius: '50%', backgroundColor: '#e8f5e9', margin: '0 auto 1rem', display: 'flex', alignItems: 'center', justifyContent: 'center' }}><span style={{ fontSize: '3rem' }}>🎙️</span></div><p style={{ color: '#00897b', fontWeight: 'bold', marginBottom: '1rem' }}>{callStatus}</p><button onClick={endCall} data-cy="btn-chat-call-end" style={{ padding: '1rem 2rem', backgroundColor: '#f44336', color: 'white', border: 'none', borderRadius: '50px', cursor: 'pointer', fontSize: '1rem' }}>End Call</button></>
            )}
        </div>
    );
}
