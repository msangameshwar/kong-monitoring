const express = require('express');

const app = express();
const PORT = 3003;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to delta GET endpoint!');
});

app.get('/delta', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to delta second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Delta server running on http://localhost:${PORT}`);
});
