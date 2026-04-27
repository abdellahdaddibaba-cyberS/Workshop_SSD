const express = require('express');
const app = express();
app.use(express.json());

// VULNERABILITY: Insecure direct object reference (IDOR) potential
// and lack of authentication check (SAST might flag logic or missing middleware)
app.get('/orders/:id', (req, res) => {
    const orderId = req.params.id;
    // In a real app, we should check if the user owns this order
    res.json({ id: orderId, item: 'Laptop', status: 'Pending' });
});

app.post('/orders', (req, res) => {
    const { productId, quantity } = req.body;
    console.log(`Order placed for product ${productId}`);
    res.status(201).json({ message: 'Order created' });
});

const PORT = 8003;
app.listen(PORT, () => {
    console.log(`Order service running on port ${PORT}`);
});
