const express = require('express');

const app = express();
const PORT = 3005;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to zeta GET endpoint!');
});

app.get('/zeta', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to zeta second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Zeta server running on http://localhost:${PORT}`);
});
