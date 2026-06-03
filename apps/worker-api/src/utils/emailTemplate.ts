/**
 * Generates a premium, responsive HTML email template for password recovery.
 * Matches PrimeCare's branding with sleek slate tones, bright blue accenting, and clear CTA.
 */
export function getForgotPasswordHtml(email: string, resetLink: string, role: string): string {
  const roleDisplay = role.toUpperCase();
  
  return `<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Your PrimeCare Password</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f8fafc;
      font-family: 'Outfit', 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      -webkit-font-smoothing: antialiased;
      color: #334155;
    }
    table {
      border-collapse: collapse;
      width: 100%;
    }
    .wrapper {
      width: 100%;
      table-layout: fixed;
      background-color: #f8fafc;
      padding: 40px 0;
    }
    .container {
      max-width: 600px;
      margin: 0 auto;
      background-color: #ffffff;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05), 0 2px 4px -2px rgb(0 0 0 / 0.05);
      border: 1px solid #e2e8f0;
    }
    .header {
      background-color: #0f172a;
      padding: 32px 40px;
      text-align: center;
    }
    .header h1 {
      color: #ffffff;
      margin: 0;
      font-size: 24px;
      font-weight: 700;
      letter-spacing: 0.5px;
    }
    .header p {
      color: #3b82f6;
      margin: 4px 0 0 0;
      font-size: 12px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 1.5px;
    }
    .content {
      padding: 40px;
    }
    .greeting {
      font-size: 20px;
      font-weight: 700;
      color: #0f172a;
      margin-top: 0;
      margin-bottom: 16px;
    }
    .body-text {
      font-size: 16px;
      line-height: 24px;
      color: #475569;
      margin-bottom: 32px;
    }
    .cta-container {
      text-align: center;
      margin-bottom: 32px;
    }
    .cta-button {
      display: inline-block;
      background-color: #2563eb;
      color: #ffffff !important;
      text-decoration: none;
      padding: 16px 32px;
      font-size: 16px;
      font-weight: 600;
      border-radius: 12px;
      box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2), 0 2px 4px -2px rgba(37, 99, 235, 0.2);
    }
    .security-badge {
      display: inline-block;
      background-color: #eff6ff;
      color: #1e40af;
      padding: 6px 12px;
      border-radius: 9999px;
      font-size: 12px;
      font-weight: 600;
      margin-bottom: 24px;
    }
    .divider {
      border-top: 1px solid #e2e8f0;
      margin: 32px 0;
    }
    .fallback-text {
      font-size: 12px;
      line-height: 18px;
      color: #64748b;
      word-break: break-all;
    }
    .fallback-link {
      color: #2563eb;
      text-decoration: underline;
    }
    .footer {
      background-color: #f1f5f9;
      padding: 32px 40px;
      text-align: center;
      font-size: 12px;
      line-height: 18px;
      color: #64748b;
    }
    .footer p {
      margin: 0 0 8px 0;
    }
    .footer p:last-child {
      margin-bottom: 0;
    }
  </style>
</head>
<body>
  <div class="wrapper">
    <div class="container">
      <div class="header">
        <h1>PrimeCare</h1>
        <p>Healthcare Platform</p>
      </div>
      <div class="content">
        <div class="security-badge">
          Security Alert: Password Reset Requested
        </div>
        <h2 class="greeting">Hello,</h2>
        <p class="body-text">
          We received a request to reset your password for the PrimeCare account associated with <strong>${email}</strong> (authorized role: <strong>${roleDisplay}</strong>).
        </p>
        
        <div class="cta-container">
          <!--[if mso]>
          <v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="${resetLink}" style="height:50px;v-text-anchor:middle;width:200px;" arcsize="24%" stroke="f" fillcolor="#2563eb">
            <w:anchorlock/>
            <center style="color:#ffffff;font-family:sans-serif;font-size:16px;font-weight:bold;">Reset Password center>
          </v:roundrect>
          <![endif]-->
          <a href="${resetLink}" class="cta-button">Reset Password</a>
        </div>

        <p class="body-text" style="margin-bottom: 0;">
          This secure link will expire in 2 hours for your protection. If you did not request a password change, you can safely ignore this email; your credentials remain secure.
        </p>

        <div class="divider"></div>

        <div class="fallback-text">
          If you're having trouble with the button above, copy and paste the URL below into your web browser:<br>
          <a href="${resetLink}" class="fallback-link">${resetLink}</a>
        </div>
      </div>
      <div class="footer">
        <p><strong>PrimeCare Technologies Inc.</strong></p>
        <p>100 University Ave, Toronto, ON, M5J 2Y1, Canada</p>
        <p>This is an automated operational security transmission. Please do not reply directly to this email.</p>
        <p>© 2026 PrimeCare. All rights reserved.</p>
      </div>
    </div>
  </div>
</body>
</html>`;
}
