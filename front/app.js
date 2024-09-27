const express = require('express');
const axios = require('axios');
const dotenv = require('dotenv');

// Load environment variables from .env file based on NODE_ENV
const env = process.env.NODE_ENV || 'development';
dotenv.config({ path: `.env.${env}` });

const app = express();
const PORT = process.env.PORT || 3000;
const BACKEND_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

app.get('/fetch-data', async (req, res) => {
    const param = req.query.param || 'default';
    try {
        const response = await axios.get(`${BACKEND_URL}/hello`, {
            params: { param: param }
        });
        res.send(response.data);
    } catch (error) {
        res.status(500).send('Error fetching data from the backend: ' + error.message);
    }
});

app.get('/', (req, res) => {
    res.send('Hello, World! I am deployed by Github Workflow!!');
});

app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});
