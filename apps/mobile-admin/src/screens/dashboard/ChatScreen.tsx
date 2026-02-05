import React, { useEffect, useState, useRef } from 'react';
import { View, Text, StyleSheet, FlatList, TextInput, TouchableOpacity, KeyboardAvoidingView, Platform } from 'react-native';
import { MobileAdminRegistry } from 'prime-care-shared';
import { chatService } from '../../services/ChatService';
import { useAuth, API_URL } from '../../context/AuthContext';
import { Message } from '../../services/MessagingService';

const { ContentRegistry } = MobileAdminRegistry;

export default function ChatScreen({ route }: any) {
    const threadId = route?.params?.threadId;
    const [messages, setMessages] = useState<Message[]>([]);
    const [inputText, setInputText] = useState('');
    const flatListRef = useRef<FlatList>(null);
    const { user, token } = useAuth();

    useEffect(() => {
        // Fetch historical messages if threadId provided
        if (threadId) {
            fetch(`${API_URL}/v1/staff/tickets/${threadId}/messages`, {
                headers: { 'Authorization': `Bearer ${token}` }
            })
                .then(res => res.json())
                .then(data => {
                    const formatted: Message[] = data.map((m: any) => ({
                        id: m.id,
                        text: m.bodyText,
                        sender: m.senderUserId === user?.id ? 'user' : 'support',
                        timestamp: m.createdAt
                    }));
                    setMessages(formatted);
                    setTimeout(() => flatListRef.current?.scrollToEnd({ animated: true }), 100);
                });
        }

        if (user?.id) {
            chatService.connect(user.id);
            const removeListener = chatService.addListener((msg) => {
                const newMessage: Message = {
                    id: Date.now().toString(),
                    text: msg.message || JSON.stringify(msg),
                    sender: msg.sender === 'user' ? 'user' : 'support',
                    timestamp: new Date().toISOString(),
                };
                setMessages(prev => [...prev, newMessage]);
                setTimeout(() => flatListRef.current?.scrollToEnd({ animated: true }), 100);
            });

            return () => {
                removeListener();
                chatService.disconnect();
            };
        }
    }, [user?.id, threadId, token]);

    const handleSend = async () => {
        if (!inputText.trim()) return;

        const text = inputText;
        setInputText('');

        if (threadId) {
            // Staff reply via REST
            const response = await fetch(`${API_URL}/v1/staff/tickets/${threadId}/reply`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({ bodyText: text }),
            });
            if (response.ok) {
                // Optimistic local echo
                const newMessage: Message = {
                    id: Date.now().toString(),
                    text: text,
                    sender: 'user',
                    timestamp: new Date().toISOString(),
                };
                setMessages(prev => [...prev, newMessage]);
                setTimeout(() => flatListRef.current?.scrollToEnd({ animated: true }), 100);
            }
        } else {
            chatService.sendMessage(text);
            const newMessage: Message = {
                id: Date.now().toString(),
                text: text,
                sender: 'user',
                timestamp: new Date().toISOString(),
            };
            setMessages(prev => [...prev, newMessage]);
            setTimeout(() => flatListRef.current?.scrollToEnd({ animated: true }), 100);
        }
    };

    const renderItem = ({ item }: { item: Message }) => (
        <View style={[
            styles.bubble,
            item.sender === 'user' ? styles.userBubble : styles.supportBubble
        ]}>
            <Text style={[
                styles.text,
                item.sender === 'user' ? styles.userText : styles.supportText
            ]}>{item.text}</Text>
            <Text style={styles.time}>{new Date(item.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</Text>
        </View>
    );

    return (
        <KeyboardAvoidingView
            style={styles.container}
            behavior={Platform.OS === 'ios' ? 'padding' : undefined}
            keyboardVerticalOffset={90}
        >
            <FlatList
                ref={flatListRef}
                data={messages}
                renderItem={renderItem}
                keyExtractor={item => item.id}
                contentContainerStyle={styles.list}
            />

            <View style={styles.inputContainer}>
                <TextInput
                    style={styles.input}
                    value={inputText}
                    onChangeText={setInputText}
                    placeholder="Type your message..."
                />

                <TouchableOpacity onPress={handleSend} style={styles.sendButton}>
                    <Text style={styles.sendButtonText}>Send</Text>
                </TouchableOpacity>
            </View>
        </KeyboardAvoidingView>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#f0f2f5' },
    list: { padding: 16, paddingBottom: 20 },
    bubble: {
        maxWidth: '80%',
        padding: 12,
        borderRadius: 16,
        marginBottom: 8,
    },
    userBubble: {
        alignSelf: 'flex-end',
        backgroundColor: '#007bff',
        borderBottomRightRadius: 4,
    },
    supportBubble: {
        alignSelf: 'flex-start',
        backgroundColor: '#fff',
        borderBottomLeftRadius: 4,
        elevation: 1,
    },
    text: { fontSize: 16 },
    userText: { color: '#fff' },
    supportText: { color: '#333' },
    time: { fontSize: 10, marginTop: 4, alignSelf: 'flex-end', opacity: 0.7 },
    inputContainer: {
        flexDirection: 'row',
        padding: 10,
        backgroundColor: '#fff',
        borderTopWidth: 1,
        borderTopColor: '#ddd',
        alignItems: 'center',
    },
    input: {
        flex: 1,
        backgroundColor: '#f9f9f9',
        borderRadius: 20,
        paddingHorizontal: 15,
        paddingVertical: 8,
        fontSize: 16,
        marginRight: 10,
        borderWidth: 1,
        borderColor: '#eee',
    },
    sendButton: {
        paddingHorizontal: 15,
        paddingVertical: 10,
    },
    sendButtonText: {
        color: '#007bff',
        fontWeight: 'bold',
        fontSize: 16,
    },
});
