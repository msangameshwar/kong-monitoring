const express = require('express');

const app = express();
const PORT = 3008;
const MAX_DELAY_MS = 6000;

const sendWithRandomDelay = (res, message) => {
  const delay = Math.floor(Math.random() * MAX_DELAY_MS) + 1;

  setTimeout(() => {
    res.send(message);
  }, delay);
};

app.get('/', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to eta GET endpoint!');
});

app.get('/eta', (req, res) => {
  sendWithRandomDelay(res, 'Welcome to eta second GET endpoint!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Eta server running on http://localhost:${PORT}`);
});
