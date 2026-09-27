CREATE TABLE screen_test_parameters (
    parameter_id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_key TEXT NOT NULL,
    parameter_key TEXT NOT NULL,
    parameter_value TEXT NOT NULL,
    description TEXT,
    UNIQUE(screen_key, parameter_key)
);

INSERT INTO screen_test_parameters (screen_key, parameter_key, parameter_value, description) VALUES
('language', 'target_route', '/language', 'Path of the language selection screen'),
('language', 'success_redirect_route', '/login', 'Path we expect to redirect to after selecting English'),
('login', 'target_route', '/login', 'Path of the login screen'),
('login', 'test_user_email', 'clinic@primecare.com', 'Admin username for L3 verification'),
('login', 'test_user_password', 'Password123', 'Admin password for L3 verification'),
('login', 'success_redirect_route', '/success', 'Path we expect to redirect to after successful login');
