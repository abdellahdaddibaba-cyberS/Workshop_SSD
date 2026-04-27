const express = require('express');
const { exec } = require('child_process');
const app = express();
app.use(express.json());

// VULNERABILITY: Command Injection (SAST should definitely catch this)
app.post('/notify', (req, res) => {
    const { email, message } = req.body;
    
    // Unsafe use of exec with user input
    const command = `echo "Sending to ${email}: ${message}"`;
    
    exec(command, (error, stdout, stderr) => {
        if (error) {
            return res.status(500).send(error.message);
        }
        res.send('Notification sent');
    });
});

const PORT = 8005;
app.listen(PORT, () => {
    console.log(`Notification service running on port ${PORT}`);
});
