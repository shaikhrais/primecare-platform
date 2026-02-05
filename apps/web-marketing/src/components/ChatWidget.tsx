import React, { useState, useRef, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from 'prime-care-shared';

const { RouteRegistry } = MarketingRegistry;
const API_URL = 'https://primecare-api.itpro-mohammed.workers.dev';

interface Message {
    id: string;
    text: string;
    sender: 'user' | 'ai';
    timestamp: Date;
}

interface ContactInfo {
    name: string;
    phone: string;
    email: string;
}

export default function ChatWidget() {
    const [isOpen, setIsOpen] = useState(false);
    const [showTooltip, setShowTooltip] = useState(true);
    const [view, setView] = useState<'menu' | 'contact' | 'chat' | 'call'>('menu');
    const [pendingAction, setPendingAction] = useState<'chat' | 'call' | null>(null);
    const [contactInfo, setContactInfo] = useState<ContactInfo>({ name: '', phone: '', email: '' });
    const [contactSubmitted, setContactSubmitted] = useState(false);
    const [messages, setMessages] = useState<Message[]>([]);
    const [inputText, setInputText] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const [isCallActive, setIsCallActive] = useState(false);
    const [callStatus, setCallStatus] = useState('');
    const messagesEndRef = useRef<HTMLDivElement>(null);

    const scrollToBottom = () => {
        messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    };

    useEffect(() => {
        scrollToBottom();
    }, [messages]);

    const handleChat = () => {
        setIsOpen(!isOpen);
        setShowTooltip(false);
        if (!isOpen) setView('menu');
    };

    const startAction = (action: 'chat' | 'call') => {
        if (contactSubmitted) {
            setView(action);
            if (action === 'chat' && messages.length === 0) {
                setMessages([{
                    id: '1',
                    text: `Hi ${contactInfo.name}! I'm PrimeCare's AI assistant. How can I help you today?`,
                    sender: 'ai',
                    timestamp: new Date()
                }]);
            }
        } else {
            setPendingAction(action);
            setView('contact');
        }
    };

    const handleContactSubmit = async () => {
        if (!contactInfo.name || !contactInfo.phone || !contactInfo.email) return;

        // Save lead to API
        try {
            await fetch(`${API_URL}/leads`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    full_name: contactInfo.name,
                    email: contactInfo.email,
                    phone: contactInfo.phone,
                    message: `Started ${pendingAction} session`,
                    source: 'contact_form'
                })
            });
        } catch (e) {
            console.log('Lead save error', e);
        }

        setContactSubmitted(true);
        if (pendingAction) {
            setView(pendingAction);
            if (pendingAction === 'chat') {
                setMessages([{
                    id: '1',
                    text: `Hi ${contactInfo.name}! I'm PrimeCare's AI assistant. How can I help you today?`,
                    sender: 'ai',
                    timestamp: new Date()
                }]);
            }
        }
    };

    const sendMessage = async () => {
        if (!inputText.trim()) return;

        const userMessage: Message = {
            id: Date.now().toString(),
            text: inputText,
            sender: 'user',
            timestamp: new Date()
        };
        setMessages(prev => [...prev, userMessage]);
        setInputText('');
        setIsLoading(true);

        try {
            await new Promise(resolve => setTimeout(resolve, 1000));

            let aiResponse = `Thank you ${contactInfo.name}. One of our care coordinators will get back to you at ${contactInfo.phone}. Is there anything specific I can help you with?`;

            const lowerText = inputText.toLowerCase();
            if (lowerText.includes('price') || lowerText.includes('cost') || lowerText.includes('rate')) {
                aiResponse = "Our rates vary based on service type. PSW home care starts at $28/hour. Foot care assessments are $75. Would you like me to have someone call you with a detailed quote?";
            } else if (lowerText.includes('book') || lowerText.includes('appointment')) {
                aiResponse = `I'd be happy to help you book an appointment! I'll have our team call you at ${contactInfo.phone}. What service are you interested in?`;
            } else if (lowerText.includes('foot care') || lowerText.includes('diabetic')) {
                aiResponse = "Our Foot Care Nurses specialize in diabetic foot care, nail care, and callus treatment. We offer home visits and facility services. Would you like to schedule an assessment?";
            } else if (lowerText.includes('psw') || lowerText.includes('personal support')) {
                aiResponse = "Our Personal Support Workers provide bathing assistance, meal prep, mobility support, and companionship. We offer flexible scheduling from 4 hours to 24/7 care.";
            }

            const aiMessage: Message = {
                id: (Date.now() + 1).toString(),
                text: aiResponse,
                sender: 'ai',
                timestamp: new Date()
            };
            setMessages(prev => [...prev, aiMessage]);
        } catch (error) {
            console.error('Chat error:', error);
        } finally {
            setIsLoading(false);
        }
    };

    const startCall = async () => {
        setIsCallActive(true);
        setCallStatus('Connecting to AI Agent...');

        try {
            await new Promise(resolve => setTimeout(resolve, 2000));
            setCallStatus('Connected! Speak now...');

            setTimeout(() => {
                setCallStatus(`AI: Hello ${contactInfo.name}! Welcome to PrimeCare. How can I assist you today?`);
            }, 3000);
        } catch (error) {
            setCallStatus('Connection failed. Please try again.');
        }
    };

    const endCall = () => {
        setIsCallActive(false);
        setCallStatus('');
        setView('menu');
    };

    return (
        <div style={{ position: 'fixed', bottom: '2rem', right: '2rem', zIndex: 9999 }}>
            {isOpen && (
                <div style={{
                    position: 'absolute',
                    bottom: '70px',
                    right: 0,
                    width: '360px',
                    height: view === 'chat' ? '500px' : 'auto',
                    backgroundColor: 'white',
                    borderRadius: '16px',
                    boxShadow: '0 10px 40px rgba(0,0,0,0.2)',
                    overflow: 'hidden',
                    display: 'flex',
                    flexDirection: 'column',
                }}>
                    {/* Header */}
                    <div style={{ backgroundColor: '#00897b', color: 'white', padding: '1rem 1.25rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div>
                            <h3 style={{ fontSize: '1.1rem', margin: 0 }}>
                                {view === 'menu' && 'How can we help?'}
                                {view === 'contact' && '📋 Your Details'}
                                {view === 'chat' && '💬 AI Chat'}
                                {view === 'call' && '📞 AI Voice Call'}
                            </h3>
                            <p style={{ fontSize: '0.8rem', opacity: 0.9, margin: '0.25rem 0 0 0' }}>
                                {view === 'menu' && 'Choose an option below'}
                                {view === 'contact' && 'We need your info to proceed'}
                                {view === 'chat' && 'Chat with our AI assistant'}
                                {view === 'call' && (isCallActive ? 'Call in progress' : 'Speak with our AI agent')}
                            </p>
                        </div>
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            {view !== 'menu' && (
                                <button onClick={() => setView('menu')} style={{ background: 'none', border: 'none', color: 'white', fontSize: '1rem', cursor: 'pointer' }}>←</button>
                            )}
                            <button onClick={() => setIsOpen(false)} style={{ background: 'none', border: 'none', color: 'white', fontSize: '1.25rem', cursor: 'pointer' }}>✕</button>
                        </div>
                    </div>

                    {/* Contact Form View */}
                    {view === 'contact' && (
                        <div style={{ padding: '1.5rem' }}>
                            <p style={{ color: '#666', fontSize: '0.9rem', marginBottom: '1rem' }}>
                                Please share your details so we can assist you better and follow up if needed.
                            </p>
                            <input
                                type="text"
                                placeholder="Your Name *"
                                value={contactInfo.name}
                                onChange={(e) => setContactInfo({ ...contactInfo, name: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', marginBottom: '0.75rem', borderRadius: '8px', border: '1px solid #ddd', fontSize: '0.9rem', boxSizing: 'border-box' }}
                            />
                            <input
                                type="tel"
                                placeholder="Phone Number *"
                                value={contactInfo.phone}
                                onChange={(e) => setContactInfo({ ...contactInfo, phone: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', marginBottom: '0.75rem', borderRadius: '8px', border: '1px solid #ddd', fontSize: '0.9rem', boxSizing: 'border-box' }}
                            />
                            <input
                                type="email"
                                placeholder="Email Address *"
                                value={contactInfo.email}
                                onChange={(e) => setContactInfo({ ...contactInfo, email: e.target.value })}
                                style={{ width: '100%', padding: '0.75rem', marginBottom: '1rem', borderRadius: '8px', border: '1px solid #ddd', fontSize: '0.9rem', boxSizing: 'border-box' }}
                            />
                            <button
                                onClick={handleContactSubmit}
                                disabled={!contactInfo.name || !contactInfo.phone || !contactInfo.email}
                                style={{
                                    width: '100%', padding: '1rem', backgroundColor: '#00897b', color: 'white',
                                    border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 'bold',
                                    opacity: (!contactInfo.name || !contactInfo.phone || !contactInfo.email) ? 0.5 : 1,
                                }}
                            >
                                Continue to {pendingAction === 'chat' ? 'AI Chat' : 'AI Call'} →
                            </button>
                            <p style={{ color: '#999', fontSize: '0.75rem', marginTop: '0.75rem', textAlign: 'center' }}>
                                We respect your privacy. Your info is used only to assist you.
                            </p>
                        </div>
                    )}

                    {/* Menu View */}
                    {view === 'menu' && (
                        <div style={{ padding: '1rem' }}>
                            <button onClick={() => startAction('chat')} style={{
                                display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', width: '100%',
                                backgroundColor: '#e8f5e9', borderRadius: '12px', border: 'none', cursor: 'pointer', marginBottom: '0.75rem', textAlign: 'left',
                            }}>
                                <span style={{ fontSize: '2rem' }}>💬</span>
                                <div>
                                    <div style={{ fontWeight: 'bold', color: '#00897b' }}>AI Text Chat</div>
                                    <div style={{ fontSize: '0.85rem', color: '#666' }}>Chat with our AI assistant</div>
                                </div>
                            </button>

                            <button onClick={() => startAction('call')} style={{
                                display: 'flex', alignItems: 'center', gap: '0.75rem', padding: '1rem', width: '100%',
                                backgroundColor: '#e3f2fd', borderRadius: '12px', border: 'none', cursor: 'pointer', marginBottom: '0.75rem', textAlign: 'left',
                            }}>
                                <span style={{ fontSize: '2rem' }}>🎙️</span>
                                <div>
                                    <div style={{ fontWeight: 'bold', color: '#1976d2' }}>AI Voice Call</div>
                                    <div style={{ fontSize: '0.85rem', color: '#666' }}>Speak with our AI agent</div>
                                </div>
                            </button>

                            <div style={{ borderTop: '1px solid #eee', paddingTop: '1rem', marginTop: '0.5rem' }}>
                                <p style={{ color: '#999', fontSize: '0.8rem', marginBottom: '0.75rem', textAlign: 'center' }}>Or contact us directly:</p>
                                <div style={{ display: 'flex', gap: '0.5rem' }}>
                                    <a href="tel:+14165551234" style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', padding: '0.75rem', backgroundColor: '#f8f9fa', borderRadius: '8px', textDecoration: 'none', color: '#333', fontSize: '0.85rem' }}>📞 Call</a>
                                    <a href="https://wa.me/14165551234" target="_blank" rel="noopener noreferrer" style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', padding: '0.75rem', backgroundColor: '#25D366', borderRadius: '8px', textDecoration: 'none', color: 'white', fontSize: '0.85rem' }}>💬 WhatsApp</a>
                                    <a href="mailto:info@primecare.ca" style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', padding: '0.75rem', backgroundColor: '#f8f9fa', borderRadius: '8px', textDecoration: 'none', color: '#333', fontSize: '0.85rem' }}>✉️ Email</a>
                                </div>
                            </div>
                        </div>
                    )}

                    {/* Chat View */}
                    {view === 'chat' && (
                        <>
                            <div style={{ flex: 1, overflowY: 'auto', padding: '1rem', backgroundColor: '#f8f9fa' }}>
                                {messages.map(msg => (
                                    <div key={msg.id} style={{ display: 'flex', justifyContent: msg.sender === 'user' ? 'flex-end' : 'flex-start', marginBottom: '0.75rem' }}>
                                        <div style={{
                                            maxWidth: '80%', padding: '0.75rem 1rem',
                                            borderRadius: msg.sender === 'user' ? '16px 16px 4px 16px' : '16px 16px 16px 4px',
                                            backgroundColor: msg.sender === 'user' ? '#00897b' : 'white',
                                            color: msg.sender === 'user' ? 'white' : '#333',
                                            boxShadow: '0 1px 2px rgba(0,0,0,0.1)',
                                        }}>
                                            {msg.text}
                                        </div>
                                    </div>
                                ))}
                                {isLoading && (
                                    <div style={{ display: 'flex', justifyContent: 'flex-start', marginBottom: '0.75rem' }}>
                                        <div style={{ padding: '0.75rem 1rem', backgroundColor: 'white', borderRadius: '16px', boxShadow: '0 1px 2px rgba(0,0,0,0.1)' }}>Typing...</div>
                                    </div>
                                )}
                                <div ref={messagesEndRef} />
                            </div>
                            <div style={{ padding: '1rem', borderTop: '1px solid #eee', display: 'flex', gap: '0.5rem' }}>
                                <input
                                    type="text"
                                    value={inputText}
                                    onChange={(e) => setInputText(e.target.value)}
                                    onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
                                    placeholder="Type your message..."
                                    style={{ flex: 1, padding: '0.75rem', borderRadius: '24px', border: '1px solid #ddd', outline: 'none', fontSize: '0.9rem' }}
                                />
                                <button onClick={sendMessage} disabled={isLoading || !inputText.trim()} style={{ padding: '0.75rem 1rem', backgroundColor: '#00897b', color: 'white', border: 'none', borderRadius: '24px', cursor: 'pointer', opacity: isLoading || !inputText.trim() ? 0.5 : 1 }}>Send</button>
                            </div>
                        </>
                    )}

                    {/* Call View */}
                    {view === 'call' && (
                        <div style={{ padding: '2rem', textAlign: 'center' }}>
                            {!isCallActive ? (
                                <>
                                    <div style={{ fontSize: '4rem', marginBottom: '1rem' }}>🎙️</div>
                                    <h4 style={{ margin: '0 0 0.5rem 0', color: '#333' }}>AI Voice Assistant</h4>
                                    <p style={{ color: '#666', fontSize: '0.9rem', marginBottom: '1.5rem' }}>Ready to help you, {contactInfo.name}</p>
                                    <button onClick={startCall} style={{ padding: '1rem 2rem', backgroundColor: '#00897b', color: 'white', border: 'none', borderRadius: '50px', cursor: 'pointer', fontSize: '1rem', fontWeight: 'bold' }}>🎤 Start Voice Call</button>
                                </>
                            ) : (
                                <>
                                    <div style={{ width: '100px', height: '100px', borderRadius: '50%', backgroundColor: '#e8f5e9', margin: '0 auto 1rem', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                        <span style={{ fontSize: '3rem' }}>🎙️</span>
                                    </div>
                                    <p style={{ color: '#00897b', fontWeight: 'bold', marginBottom: '1rem' }}>{callStatus}</p>
                                    <button onClick={endCall} style={{ padding: '1rem 2rem', backgroundColor: '#f44336', color: 'white', border: 'none', borderRadius: '50px', cursor: 'pointer', fontSize: '1rem' }}>End Call</button>
                                </>
                            )}
                        </div>
                    )}

                    {view === 'menu' && (
                        <div style={{ padding: '0.75rem', borderTop: '1px solid #eee', textAlign: 'center' }}>
                            <Link to={RouteRegistry.CONTACT} onClick={() => setIsOpen(false)} style={{ color: '#00897b', textDecoration: 'none', fontWeight: 'bold', fontSize: '0.85rem' }}>Or visit our Contact Page →</Link>
                        </div>
                    )}
                </div>
            )}

            {/* Floating Button */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                {showTooltip && !isOpen && (
                    <div style={{
                        backgroundColor: 'white',
                        padding: '0.75rem 1rem',
                        borderRadius: '50px',
                        boxShadow: '0 4px 15px rgba(0,0,0,0.15)',
                        fontSize: '0.9rem',
                        color: '#333',
                    }}>
                        Chat with us 👋
                    </div>
                )}
                <button
                    onClick={handleChat}
                    style={{
                        width: '56px',
                        height: '56px',
                        borderRadius: '50%',
                        backgroundColor: isOpen ? '#333' : '#f59e0b',
                        border: 'none',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        boxShadow: '0 4px 15px rgba(0,0,0,0.2)',
                        transition: 'transform 0.2s',
                    }}
                    onMouseOver={(e) => e.currentTarget.style.transform = 'scale(1.1)'}
                    onMouseOut={(e) => e.currentTarget.style.transform = 'scale(1)'}
                >
                    <span style={{ fontSize: '1.5rem' }}>{isOpen ? '✕' : '💬'}</span>
                </button>
            </div>
        </div>
    );
}
