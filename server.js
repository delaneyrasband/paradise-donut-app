require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: 3306,
  waitForConnections: true,
  connectionLimit: 10
});

app.get('/health', (req, res) => {
  res.json({ status: 'OK', message: 'Paradise Donut App running!' });
});

app.get('/api/flavors', (req, res) => {
  db.query('SELECT * FROM flavors ORDER BY created_at DESC', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.post('/api/flavors', (req, res) => {
  const { flavor_name, description, price, in_stock } = req.body;
  const sql = 'INSERT INTO flavors (flavor_name, description, price, in_stock) VALUES (?, ?, ?, ?)';
  db.query(sql, [flavor_name, description, price, in_stock || true], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.status(201).json({ id: result.insertId, message: 'Added!' });
  });
});

app.delete('/api/flavors/:id', (req, res) => {
  db.query('DELETE FROM flavors WHERE id = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Deleted!' });
  });
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Paradise Donut App on port ${PORT}`);
});