const express = require('express');

let Note = require('../../Note');
const router = express.Router();

//create note
router.post("/",
 async (req, res) => {
    try {
        const newNote = new Note({
            date: req.body.date,
            note: req.body.note
        });
        const result = await newNote.save().then(() => {
            if (newNote.isNew == false) {
                console.log("Note saved");
                res.send(result);
            } else {
                console.log("Failed to save note");
            }
        })
    } catch(err){
        console.log(err);
        res.status(500).send("Server error");
    }
});

//delete note
router.delete('/', async (req, res) => {
    try{
        const deleteNote = await Note.findById(req.body.id);
        if(!deleteNote){
            return res.status(404).send('No notes');
        }
        const result = await Note.findByIdAndDelete(req.body.id);
        console.log("Note deleted");
        res.send(result);
    }catch(err){
        res.status(500).send("Server error");
    }
    
});

//update note
router.put('/', async (req, res) => {
    try{
        const updateNote = await Note.findById(req.body.id);
        if(!updateNote){
            return res.status(404).send('No note');
        }
        updateNote.date = req.body.date;
        updateNote.note = req.body.note;
        await updateNote.save();
        console.log("Note updated")
        res.send(updateNote);
    }catch(err){
        res.status(500).send("Server error");
    }
    
});

//fetch all notes
router.get('/', async (req, res) => {
    try{
        const notes = await Note.find();
        console.log("Nots fetched");
        const notesReversed = notes.reverse()
        res.send(notesReversed);
    }catch (err){
        res.status(500).send("Server error");
    }
});

module.exports = router;