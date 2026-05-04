const express = require('express');
const app = express();
const port = 8002;

app.get('/', (req, res) => {
  res.json({ message: 'Product Service is running' });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});

app.listen(port, () => {
  console.log(`Product Service listening at http://localhost:${port}`);
});
