const express = require('express');
const axios = require('axios');
const dotenv = require('dotenv');
const path = require('path');

// Load environment variables from .env file based on NODE_ENV
const env = process.env.NODE_ENV || 'development';
dotenv.config({ path: `.env.${env}` });

const app = express();
const PORT = process.env.PORT || 3000;
const BACKEND_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

// Serve static files from the 'public' folder
app.use(express.static(path.join(__dirname, 'public')));

// Serve the index page from the 'views' folder
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'index.html'));
});

// Fetch data and serve result page
app.get('/fetch-data', async (req, res) => {
    const param = req.query.param || 'default';
    try {
        const response = await axios.get(`${BACKEND_URL}/hello`, {
            params: { param: param }
        });
        res.sendFile(path.join(__dirname, 'views', 'fetch-data.html'));
    } catch (error) {
        res.status(500).sendFile(path.join(__dirname, 'views', 'error.html'));
    }
});

app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});
