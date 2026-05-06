const express = require('express');

const app = express();
const PORT = 3007;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to theta GET endpoint!');
});

app.get('/theta', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to theta second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Theta server running on http://localhost:${PORT}`);
});
