const express = require('express');
const csrf = require('csurf');
const cookieParser = require('cookie-parser');
const app = express();

const port = 8004;
app.use(cookieParser());
app.use(csrf({ cookie: true }));
app.get('/', (req, res) => {
  res.json({ message: 'Payment Service is running' });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});

app.listen(port, () => {
  console.log(`Payment Service listening at http://localhost:${port}`);
});
