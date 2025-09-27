import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
//import { connect } from "mongoose";
//import Todo from "./Models/Todomodels.js";
import connectionDB from './db.js';
// Load environment variables from .env file
import todoroutes from './routes/todoroutes.js';
//const client = require('prom-client');

// Initialize environment variables
// Load environment variables
dotenv.config();

// Create Express app
const app = express();

// Connect to MongoDB
connectionDB();

// Middleware to parse JSON bodies (using Express's built-in)
app.use(express.json());   // Parse JSON
app.use(cors());

// Route Mounting
app.use('/api', todoroutes); // <--- All your routes are now under /api

app.get("/",(req,res)=> {
  res.status(200).json({message:"hello from server"})
})

app.get('/api/test', (req, res) => {
  res.json({ success: true, message: "API is working" });
});


const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });


/*
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
});

*/
  
// GET route to retrieve all todos
 /*app.get('/get-todos', async (req, res) => {
  try {
    // Fetch all todos from the database
    const todos = await Todo.find();
    console.log('Fetched todos:', todos);

    // Send the todos as the response
    res.status(200).json(todos);
  } catch (err) {
    console.error('Error fetching todos:', err);
    res.status(500).json({ error: 'Failed to fetch todos' });
  }
});*/


/*app.post('/add-todo',async(req, res) => {
  
  try {
    const  title  = req.body.todo; // Use 'todo' to match React
    console.log('Adding a todo:', title);

    const newTodo = new Todo({
      title: title, // Use 'todo' for the title
    });

    console.log('Adding a todo', newTodo);
    const savedTodo = await newTodo.save(); // Save the new todo
    console.log('Added a todo', savedTodo);

    res.status(200).json(savedTodo);
  } catch (err) {
    console.error('Error saving todo:', err);
    res.status(500).json({ error: 'Failed to save todo' });
  }
})
  
*/

