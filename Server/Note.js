const mongoose = require('mongoose');

const NoteSchema = new mongoose.Schema({
    date: String,
    note: String,
});

module.exports = mongoose.model('Notev2', NoteSchema);