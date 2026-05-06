const express = require('express');

const app = express();
const PORT = 3000;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Hello from alpha GET endpoint!');
});

app.get('/alpha', (req, res) => {
  sendWithRandomDelay(res, 'Hello from alpha second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Alpha server running on http://localhost:${PORT}`);
});
