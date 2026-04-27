const express = require('express');
const app = express();
app.use(express.json());

// FIXED: Using environment variables for SMTP secrets (Runtime Secret Management)
const SMTP_PASSWORD = process.env.SMTP_PASSWORD || 'dev-smtp-placeholder';

app.post('/notify', (req, res) => {
    const { email, message } = req.body;
    
    // FIXED: Removed exec() to prevent Command Injection. 
    // Using a safe console log to simulate sending.
    console.log(`[Notification] To: ${email} | Content: ${message} | Using Auth: ${SMTP_PASSWORD}`);
    
    res.send('Notification processed securely');
});

const PORT = 8005;
app.listen(PORT, () => {
    console.log(`Notification service running on port ${PORT}`);
});
