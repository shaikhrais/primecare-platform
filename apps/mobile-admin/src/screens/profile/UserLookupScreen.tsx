import React, { useState } from 'react';
import { View, Text, TextInput, StyleSheet, FlatList, TouchableOpacity, SafeAreaView, ActivityIndicator } from 'react-native';
import { useAuth, API_URL } from '../../context/AuthContext';

export default function UserLookupScreen() {
    const { token } = useAuth();
    const [search, setSearch] = useState('');
    const [results, setResults] = useState<any[]>([]);
    const [loading, setLoading] = useState(false);

    const handleSearch = () => {
        if (!search.trim()) return;
        setLoading(true);
        fetch(`${API_URL}/v1/staff/customers`, {
            headers: { 'Authorization': `Bearer ${token}` }
        })
            .then(res => res.json())
            .then(data => {
                const users = Array.isArray(data) ? data : [];
                const filtered = users.filter((u: any) =>
                    u.fullName?.toLowerCase().includes(search.toLowerCase()) ||
                    u.user?.email?.toLowerCase().includes(search.toLowerCase())
                );
                setResults(filtered);
                setLoading(false);
            })
            .catch(() => setLoading(false));
    };

    return (
        <SafeAreaView style={styles.container}>
            <View style={styles.searchBox}>
                <TextInput
                    style={styles.input}
                    placeholder="Search by name or email..."
                    value={search}
                    onChangeText={setSearch}
                    onSubmitEditing={handleSearch}
                />
                <TouchableOpacity style={styles.button} onPress={handleSearch}>
                    <Text style={styles.buttonText}>Search</Text>
                </TouchableOpacity>
            </View>

            {loading ? (
                <ActivityIndicator size="large" color="#004d40" style={{ marginTop: 20 }} />
            ) : (
                <FlatList
                    data={results}
                    keyExtractor={item => item.id}
                    contentContainerStyle={styles.list}
                    renderItem={({ item }) => (
                        <View style={styles.userCard}>
                            <View>
                                <Text style={styles.userName}>{item.fullName}</Text>
                                <Text style={styles.userEmail}>{item.user?.email}</Text>
                            </View>
                            <View style={roleStyle(item.user?.status)}>
                                <Text style={styles.statusText}>{item.user?.status?.toUpperCase() || 'ACTIVE'}</Text>
                            </View>
                        </View>
                    )}
                    ListEmptyComponent={
                        search.length > 0 ? (
                            <Text style={styles.emptyText}>No users found.</Text>
                        ) : null
                    }
                />
            )}
        </SafeAreaView>
    );
}

const roleStyle = (status: string) => ({
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4,
    backgroundColor: status === 'active' ? '#e8f5e9' : '#ffebee'
});

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#fff' },
    searchBox: { padding: 20, flexDirection: 'row', gap: 10 },
    input: { flex: 1, height: 45, borderColor: '#ddd', borderWidth: 1, borderRadius: 8, paddingHorizontal: 15 },
    button: { backgroundColor: '#004d40', height: 45, paddingHorizontal: 20, borderRadius: 8, justifyContent: 'center' },
    buttonText: { color: '#fff', fontWeight: 'bold' },
    list: { padding: 20 },
    userCard: {
        padding: 15,
        borderBottomWidth: 1,
        borderBottomColor: '#eee',
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center'
    },
    userName: { fontWeight: 'bold', fontSize: 16, color: '#333' },
    userEmail: { fontSize: 14, color: '#666' },
    statusText: { fontSize: 10, fontWeight: 'bold', color: '#004d40' },
    emptyText: { textAlign: 'center', marginTop: 40, color: '#999' }
});
