import React, { useRef, useState, useCallback } from 'react';
import { Camera, X, Check, RefreshCw } from 'lucide-react';
import { useNotification } from '@/shared/context/NotificationContext';

interface SecureCameraProps {
    onCapture: (base64Data: string) => void;
    onClose: () => void;
}

export const SecureCamera: React.FC<SecureCameraProps> = ({ onCapture, onClose }) => {
    const videoRef = useRef<HTMLVideoElement>(null);
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const [stream, setStream] = useState<MediaStream | null>(null);
    const [photo, setPhoto] = useState<string | null>(null);
    const [error, setError] = useState<string | null>(null);
    const { showToast } = useNotification();

    const startCamera = async () => {
        try {
            const mediaStream = await navigator.mediaDevices.getUserMedia({
                video: { facingMode: 'environment' } // Prefer back camera
            });
            setStream(mediaStream);
            if (videoRef.current) {
                videoRef.current.srcObject = mediaStream;
            }
        } catch (err) {
            console.error('Camera access denied:', err);
            setError('Camera access is required for secure charting.');
        }
    };

    const stopCamera = useCallback(() => {
        if (stream) {
            stream.getTracks().forEach(track => track.stop());
            setStream(null);
        }
    }, [stream]);

    // Cleanup on unmount
    React.useEffect(() => {
        startCamera();
        return () => stopCamera();
    }, [stopCamera]);

    const takePhoto = () => {
        if (!videoRef.current || !canvasRef.current) return;

        const video = videoRef.current;
        const canvas = canvasRef.current;

        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;

        const context = canvas.getContext('2d');
        if (context) {
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            // Convert directly to base64, NEVER saving to device storage
            const dataUrl = canvas.toDataURL('image/jpeg', 0.8);
            setPhoto(dataUrl);
            stopCamera();
        }
    };

    const handleApprove = () => {
        if (photo) {
            onCapture(photo);
            showToast('Secure image captured (HIPAA compliant).', 'success');
        }
    };

    const handleRetake = () => {
        setPhoto(null);
        startCamera();
    };

    return (
        <div style={{
            position: 'fixed',
            inset: 0,
            backgroundColor: 'black',
            zIndex: 10000,
            display: 'flex',
            flexDirection: 'column'
        }}>
            {/* Header */}
            <div style={{
                padding: '24px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                backgroundColor: 'rgba(0,0,0,0.5)',
                position: 'absolute',
                top: 0,
                left: 0,
                right: 0,
                zIndex: 10
            }}>
                <div style={{ color: 'white', display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <div style={{ padding: '4px 8px', backgroundColor: '#3B82F6', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 700 }}>SECURE CAPTURE</div>
                    <span style={{ fontSize: '0.9rem' }}>No Camera Roll Data</span>
                </div>
                <button data-cy="btn-shared.secure-camera-0" onClick={() => { stopCamera(); onClose(); }} style={{ background: 'none', border: 'none', color: 'white', cursor: 'pointer' }}>
                    <X size={28} />
                </button>
            </div>

            {/* Viewfinder */}
            <div style={{ flex: 1, position: 'relative', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                {error ? (
                    <div style={{ color: 'white', textAlign: 'center', padding: '24px' }}>
                        <Camera size={48} color="#64748B" style={{ marginBottom: '16px' }} />
                        <p>{error}</p>
                    </div>
                ) : photo ? (
                    <img src={photo} alt="Captured" style={{ width: '100%', height: '100%', objectFit: 'contain' }} />
                ) : (
                    <video
                        ref={videoRef}
                        autoPlay
                        playsInline
                        style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                    />
                )}
                <canvas ref={canvasRef} style={{ display: 'none' }} />
            </div>

            {/* Controls */}
            <div style={{
                padding: '40px 24px',
                backgroundColor: 'black',
                display: 'flex',
                justifyContent: 'center',
                gap: '40px',
                alignItems: 'center',
                minHeight: '140px'
            }}>
                {photo ? (
                    <>
                        <button data-cy="btn-shared.secure-camera-1" onClick={handleRetake} style={{ background: 'none', border: 'none', color: 'white', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                            <div style={{ width: '56px', height: '56px', borderRadius: '28px', backgroundColor: '#334155', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                <RefreshCw size={24} />
                            </div>
                            <span>Retake</span>
                        </button>
                        <button data-cy="btn-shared.secure-camera-2" onClick={handleApprove} style={{ background: 'none', border: 'none', color: 'white', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                            <div style={{ width: '72px', height: '72px', borderRadius: '36px', backgroundColor: '#10B981', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                <Check size={36} color="white" />
                            </div>
                            <span style={{ fontWeight: 700 }}>Use Photo</span>
                        </button>
                    </>
                ) : (
                    <button data-cy="btn-shared.secure-camera-3"
                        onClick={takePhoto}
                        disabled={!!error}
                        style={{
                            width: '80px',
                            height: '80px',
                            borderRadius: '40px',
                            backgroundColor: 'transparent',
                            border: '4px solid white',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            cursor: error ? 'not-allowed' : 'pointer'
                        }}
                    >
                        <div style={{ width: '64px', height: '64px', borderRadius: '32px', backgroundColor: 'white' }} />
                    </button>
                )}
            </div>
        </div>
    );
};
