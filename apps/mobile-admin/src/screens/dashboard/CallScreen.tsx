
import React, { useEffect, useState, useRef } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Platform, PermissionsAndroid } from 'react-native';
// @ts-ignore
import AudioRecorderPlayer from 'react-native-audio-recorder-player';
import { useAuth, API_URL } from '../../context/AuthContext';
import { ClientRegistry } from 'prime-care-shared';

const { ContentRegistry } = ClientRegistry;

// @ts-ignore
const audioRecorderPlayer = new AudioRecorderPlayer();

enum CallState {
    IDLE = 'IDLE',
    LISTENING = 'LISTENING', // User is speaking / Mic open
    PROCESSING = 'PROCESSING', // Silence detected, uploading...
    SPEAKING = 'SPEAKING', // AI is speaking (Audio playing)
}

export default function CallScreen({ navigation }: any) {
    const { user } = useAuth();
    const [callState, setCallState] = useState<CallState>(CallState.LISTENING);
    const [metering, setMetering] = useState(-160);
    const silenceTimeoutRef = useRef<NodeJS.Timeout | null>(null);
    const isRecordingRef = useRef(false);

    // VAD Parameters
    const SILENCE_THRESHOLD = -50; // dB
    const SILENCE_DURATION = 1500; // ms to wait before sending

    useEffect(() => {
        startSession();
        return () => {
            stopSession();
        };
    }, []);

    const startSession = async () => {
        if (Platform.OS === 'android') {
            const grants = await PermissionsAndroid.requestMultiple([
                PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE,
                PermissionsAndroid.PERMISSIONS.READ_EXTERNAL_STORAGE,
                PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
            ]);
            if (grants['android.permission.RECORD_AUDIO'] !== PermissionsAndroid.RESULTS.GRANTED) {
                console.log('Permission denied');
                return;
            }
        }
        startListening();
    };

    const stopSession = async () => {
        try {
            if (isRecordingRef.current) {
                await audioRecorderPlayer.stopRecorder();
            }
            audioRecorderPlayer.removeRecordBackListener();
            audioRecorderPlayer.stopPlayer();
            audioRecorderPlayer.removePlayBackListener();
        } catch (e) { }
    };

    const startListening = async () => {
        setCallState(CallState.LISTENING);
        try {
            const uri = await audioRecorderPlayer.startRecorder(undefined, undefined, true); // true for metering
            isRecordingRef.current = true;

            audioRecorderPlayer.addRecordBackListener((e: any) => {
                const currentMetering = e.currentMetering;
                setMetering(currentMetering);

                if (currentMetering > SILENCE_THRESHOLD) {
                    // User is talking, clear silence timer
                    if (silenceTimeoutRef.current) {
                        clearTimeout(silenceTimeoutRef.current);
                        silenceTimeoutRef.current = null;
                    }
                } else {
                    // Silence detected
                    if (!silenceTimeoutRef.current) {
                        silenceTimeoutRef.current = setTimeout(() => {
                            stopListeningAndSend();
                        }, SILENCE_DURATION);
                    }
                }
            });
        } catch (e) {
            console.error(e);
        }
    };

    const stopListeningAndSend = async () => {
        if (!isRecordingRef.current) return;

        // Stop Recorder
        const result = await audioRecorderPlayer.stopRecorder();
        audioRecorderPlayer.removeRecordBackListener();
        isRecordingRef.current = false;

        setCallState(CallState.PROCESSING);

        // Upload
        await uploadAndGetReply(result);
    };

    const uploadAndGetReply = async (uri: string) => {
        const formData = new FormData();
        const file = {
            uri: uri,
            name: 'voice_input.mp4',
            type: 'audio/mp4',
        };
        formData.append('file', file as any);
        formData.append('userId', user?.id || 'guest');

        try {
            // 1. Upload to Worker -> R2 -> n8n (Webhook)
            // Note: This endpoint triggers n8n, but in a real call loop, we might want a direct response.
            // For now, let's assume the Worker echoes back the response or we poll/wait for websocket.
            // BUT, for a VAD loop, HTTP response is easier than async WebSocket for "Call" mode.
            // Let's assume the /upload endpoint returns the AI response URL directly or we hit a different endpoint.
            // *Wait*, our current /upload triggers a webhook but returns the *uploaded* file URL.
            // We need an endpoint that returns the AI reply. 
            // VAD approach usually requires a more streaming setup or a request-response endpoint.
            // Let's stub this "AI Reply" for now with a direct fetch to n8n if possible, or modify backend.
            // For this iteration, let's use the existing upload, and assume we listen for the WebSocket reply.

            await fetch(`${API_URL}/v1/voice/upload`, {
                method: 'POST',
                headers: { 'Content-Type': 'multipart/form-data' },
                body: formData,
            });

            // In a real implementation, we'd wait for the WebSocket message here.
            // For this UI demo, we'll simulate "Speaking" state then go back to listening.
            // Real integration: The WebSocket listener in ChatService would trigger the playback.

            // SIMULATION OF AI REPLY PLAYBACK for VAD loop demo
            // In reality, this would be triggered by chatService listener
            setTimeout(() => {
                setCallState(CallState.SPEAKING);
                // Play dummy audio or last received audio
                // onAudioFinished -> startListening();
                setTimeout(() => {
                    startListening(); // Loop back
                }, 3000);
            }, 2000);

        } catch (e) {
            console.error('Upload failed', e);
            startListening(); // Retry
        }
    };

    return (
        <View style={styles.container}>
            <View style={styles.content}>
                <View style={[styles.circle, getStatusColor(callState, metering)]}>
                    <Text style={styles.icon}>{getStatusIcon(callState)}</Text>
                </View>
                <Text style={styles.statusText}>{getStatusText(callState)}</Text>
            </View>

            <TouchableOpacity style={styles.hangupBtn} onPress={() => navigation.goBack()}>
                <Text style={styles.hangupText}>End Call</Text>
            </TouchableOpacity>
        </View>
    );
}

const getStatusColor = (state: CallState, metering: number) => {
    switch (state) {
        case CallState.LISTENING:
            // Pulse effect based on metering could happen here
            return { backgroundColor: metering > -40 ? '#4CAF50' : '#81C784', transform: [{ scale: metering > -40 ? 1.2 : 1 }] };
        case CallState.PROCESSING:
            return { backgroundColor: '#FFC107' };
        case CallState.SPEAKING:
            return { backgroundColor: '#2196F3' };
        default:
            return { backgroundColor: '#ccc' };
    }
};

const getStatusIcon = (state: CallState) => {
    switch (state) {
        case CallState.LISTENING: return '👂';
        case CallState.PROCESSING: return '⏳';
        case CallState.SPEAKING: return '🤖';
        default: return '';
    }
};

const getStatusText = (state: CallState) => {
    switch (state) {
        case CallState.LISTENING: return 'Listening...';
        case CallState.PROCESSING: return 'Thinking...';
        case CallState.SPEAKING: return 'Agent Speaking...';
        default: return 'Connecting...';
    }
};

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#222', justifyContent: 'center', alignItems: 'center' },
    content: { alignItems: 'center', flex: 1, justifyContent: 'center' },
    circle: {
        width: 150, height: 150, borderRadius: 75,
        justifyContent: 'center', alignItems: 'center',
        marginBottom: 30,
    },
    icon: { fontSize: 60 },
    statusText: { color: '#fff', fontSize: 24, fontWeight: '600' },
    hangupBtn: {
        backgroundColor: '#f44336',
        paddingVertical: 15, paddingHorizontal: 40,
        borderRadius: 30, marginBottom: 50,
    },
    hangupText: { color: '#fff', fontSize: 18, fontWeight: 'bold' },
});
