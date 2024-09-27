const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000; // Allow port to be set via environment variable

// Use the REACT_APP_API_URL environment variable for backend communication
const BACKEND_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080/api';

// Example route that interacts with the Spring Boot backend
app.get('/fetch-data', async (req, res) => {
    const param = req.query.param || 'default'; // Get param from query or use a default value
    try {
        const response = await axios.get(`${BACKEND_URL}/hello`, {
            params: { param: param } // Send param to the Spring Boot backend
        });
        res.send(response.data); // Send the backend response to the client
    } catch (error) {
        res.status(500).send('Error fetching data from the backend: ' + error.message);
    }
});

// Root route
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});
