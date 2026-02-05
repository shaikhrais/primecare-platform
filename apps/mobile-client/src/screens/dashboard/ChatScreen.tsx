import React, { useEffect, useState, useRef } from 'react';
import { View, Text, StyleSheet, FlatList, TextInput, TouchableOpacity, KeyboardAvoidingView, Platform } from 'react-native';
import { ClientRegistry } from 'prime-care-shared';
import { chatService } from '../../services/ChatService';
import { useAuth } from '../../context/AuthContext';
// Keep Message type definition if it's reused, or define it locally if strictly simple
import { Message } from '../../services/MessagingService';

const { ContentRegistry } = ClientRegistry;

export default function ChatScreen() {
    const [messages, setMessages] = useState<Message[]>([]);
    const [inputText, setInputText] = useState('');
    const flatListRef = useRef<FlatList>(null);
    const { user } = useAuth(); // Assuming useAuth exposes the user object

    useEffect(() => {
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

                // Scroll to bottom on new message
                setTimeout(() => flatListRef.current?.scrollToEnd({ animated: true }), 100);
            });

            return () => {
                removeListener();
                chatService.disconnect();
            };
        }
    }, [user?.id]);

    const handleSend = async () => {
        if (!inputText.trim()) return;

        const text = inputText;
        setInputText('');

        chatService.sendMessage(text);

        // Optimistic update
        const newMessage: Message = {
            id: Date.now().toString(),
            text: text,
            sender: 'user',
            timestamp: new Date().toISOString(),
        };
        setMessages(prev => [...prev, newMessage]);

        setTimeout(() => flatListRef.current?.scrollToEnd({ animated: true }), 100);
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
                    placeholder={ContentRegistry.CHAT.SEND_PLACEHOLDER}
                />

                <TouchableOpacity onPress={handleSend} style={styles.sendButton}>
                    <Text style={styles.sendButtonText}>{ContentRegistry.CHAT.SEND_BTN}</Text>
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
