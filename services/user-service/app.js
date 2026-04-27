const express = require('express');
const jwt = require('jsonwebtoken');

const app = express();
app.use(express.json());

// FIXED: Using Environment Variable instead of hardcoded secret
const JWT_SECRET = process.env.JWT_SECRET || 'fallback-dev-key-only';

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    // In a real app, use a hashed password comparison
    if (username === 'admin' && password === 'admin') {
        const token = jwt.sign({ username }, JWT_SECRET, { expiresIn: '1h' });
        return res.json({ token });
    }
    res.status(401).send('Unauthorized');
});

const PORT = 8001;
app.listen(PORT, () => {
    console.log(`User service running on port ${PORT}`);
});
