# capstone
The codebase demonstrates an iOS application created using Swift and SwiftUI. The primary objective is to showcase secure authentication flows, role-based access control, and the foundations for secure network communication (including TLS pinning). While the backend logic and network requests have been simulated or partially stubbed out, the structure allows for easy integration with real services and more advanced security measures.

The main functionalities include:
	•	Authentication Flow: Users can enter credentials and log into the app. The logic simulates scenarios requiring Multi-Factor Authentication (MFA).
	•	Role-Based Access Control: Admin and regular user roles determine which features are accessible.
	•	Secure (Placeholder) Networking: A NetworkService class sets the stage for implementing TLS pinning, a robust defense against Man-in-the-Middle (MITM) attacks.
	•	UI Flow Control: The ContentView dynamically updates the UI based on authentication state, ensuring that sensitive screens only appear after successful authentication.

This design aligns with common cybersecurity best practices by separating concerns (authentication logic, UI, and potential secure networking), emphasizing least privilege (role-based access), and planning for secure communication channels.

Code Architecture and Flow
	1.	App Entry Point (MyApp):
Uses the SwiftUI @main App protocol. On launch, it instantiates an AuthViewModel which manages authentication state. The ContentView is wrapped in .environmentObject(authViewModel), allowing all child views to access and modify authentication state securely.
	2.	ViewModel (AuthViewModel):
This central component orchestrates the authentication logic. It:
	•	Maintains user credentials, MFA codes, and roles.
	•	Interacts with AuthService to simulate login and MFA verification.
	•	Tracks AuthState (unauthenticated, MFA required, or authenticated).
	•	Assigns roles (admin vs. user) post-authentication to enforce least privilege principles. Only admin users see certain sensitive features, exemplifying role-based access control.
	3.	AuthService:
While currently simulating network calls, AuthService would, in a production environment, handle real communication with a backend server. Here it:
	•	Distinguishes between ordinary logins and those requiring MFA.
	•	Stores a simulated token on successful login, representing a granted session.
This token would, in a real scenario, be protected via secure storage (e.g., Keychain) and used for authenticated API requests. Proper token handling prevents unauthorized access if an attacker gains local filesystem access or intercepts network traffic.
	4.	ContentView and UI State Handling:
The ContentView uses a switch on authVM.state to decide which view to present:
	•	LoginView for unauthenticated states.
	•	MFAView if MFA is required.
	•	HomeView once fully authenticated.
By leveraging SwiftUI’s reactive design, state changes in AuthViewModel automatically update the UI. This ensures a clean separation of concerns: no UI is displayed that the user isn’t entitled to see, minimizing the risk of unauthorized viewing of sensitive screens.
	5.	Login and MFA Views:
	•	LoginView prompts for credentials. Pressing “Login” calls authVM.login(). If credentials indicate MFA, the user is seamlessly taken to MFAView.
	•	MFAView simulates a second authentication factor, reinforcing the principle of defense in depth. Even if a password is compromised, the attacker still requires the MFA code.
	6.	HomeView and Role-Based Features:
After successful authentication, HomeView presents several icons leading to different app functionalities. If the user’s role is .admin, they gain access to the Documents section. A non-admin user sees “No Admin Access.” This is a straightforward demonstration of role-based access control, ensuring sensitive features (e.g., managing crucial data) are only accessible to authorized entities.

Cybersecurity Considerations
	1.	Multi-Factor Authentication (MFA):
MFA is a critical security measure. Even though the current code simulates MFA, the structure is in place to integrate with real-world MFA providers (e.g., TOTP-based authenticators, SMS codes, or push notifications). This significantly reduces the risk of unauthorized access from credential theft alone.
	2.	Role-Based Access Control (RBAC):
By assigning roles (admin vs. user) after authentication, the app adheres to the principle of least privilege. Users only gain privileges necessary for their role. Admin-only features are safeguarded against misuse by regular users. This mitigates internal threat vectors and unauthorized data access.
	3.	Separation of Concerns:
The separation between AuthService, AuthViewModel, and UI views reduces the attack surface. The AuthService can be swapped out with a more secure, production-grade implementation. Sensitive logic and data handling remain encapsulated, making it easier to audit and update security measures.
	4.	Potential Secure Token Storage:
Although the code currently simulates token storage in memory, integrating Keychain storage would be a logical next step. Storing session tokens securely in the iOS Keychain prevents attackers who can read local storage from easily hijacking sessions. With Keychain, tokens are protected even if the device is compromised at the filesystem level.
	5.	TLS Pinning (NetworkService):
While currently not fully integrated with real endpoints, the NetworkService class demonstrates how to implement TLS pinning. Pinning ensures that the client trusts only a specific server’s public key or certificate. Even if a malicious actor obtains a valid TLS certificate from a trusted CA or tries to proxy the connection, pinning would cause the connection to fail. This drastically reduces the risk of Man-in-the-Middle attacks, a common threat in insecure network environments.
Once integrated with real network calls in AuthService, TLS pinning ensures encrypted communications are not only secure in theory (TLS) but also resistant to sophisticated MITM attempts.
