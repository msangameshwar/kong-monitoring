const express = require('express');

const app = express();
const PORT = 3001;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Hello from beta GET endpoint!');
});

app.get('/beta', (req, res) => {
  sendWithRandomDelay(res, 'Hello from beta second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Beta server running on http://localhost:${PORT}`);
});
