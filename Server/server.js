const express = require('express');
const mongoose = require('mongoose');
const app = express();
const notesRouter = require('./routes/api/notesRouter');
const dbURL = ""

mongoose.connect(dbURL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

mongoose.connection.once("open", () => {
    console.log("Connected to database")
}).on("error", (error) => {
    console.log("Failed to connect to database: "+error)
});

//set the server ip so all devices in the same wifi network could have access to it
app.use(express.json());
app.use('/api/notes', notesRouter);

app.listen(8081, "10.0.0.19", () => {
    console.log("Server running")
});