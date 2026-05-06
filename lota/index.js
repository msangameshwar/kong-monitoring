const express = require('express');

const app = express();
const PORT = 3006;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to lota GET endpoint!');
});

app.get('/lota', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to lota second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Lota server running on http://localhost:${PORT}`);
});
