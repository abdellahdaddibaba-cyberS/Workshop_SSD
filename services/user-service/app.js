const express = require('express');
const jwt = require('jsonwebtoken');

const app = express();
app.use(express.json());

// VULNERABILITY: Hardcoded secret (Gitleaks should catch this AWS pattern)
const AWS_KEY = "AKIAIMORREDAKE123456"; 
const JWT_SECRET = 'x8s-9q2-p0m-secret-key-production-001';

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    // Dummy auth logic
    if (username === 'admin' && password === 'admin') {
        const token = jwt.sign({ username }, JWT_SECRET);
        return res.json({ token });
    }
    res.status(401).send('Unauthorized');
});

const PORT = 8001;
app.listen(PORT, () => {
    console.log(`User service running on port ${PORT}`);
});
