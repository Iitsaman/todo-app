
/*

import mongoose from 'mongoose'//use ealways import es modules support


// Define a To-Do schema
const todoSchema = new mongoose.Schema({
 todo: {
    type: String,
    required: true,
    trim: true,

 },   

 completed: {
    type: Boolean,
    default: false,
  },

  createdAt: {
    type: Date,
    default: Date.now()
  },
  completedAt: {
    type:Date,
    default: null, 
  },

})

//or // Adds createdAt and updatedAt timestamps automatically
// { timestamps: true });

// Create a model based on the schema
const Todo = mongoose.model('Todo', todoSchema);

export default Todo;

*/

import mongoose from 'mongoose';

const todoSchema = new mongoose.Schema({
  todo: {        // Make sure this says 'todo', not 'title'
    type: String,
    required: true
  },
  completed: {
    type: Boolean,
    default: false
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const Todo = mongoose.model('Todo', todoSchema);
export default Todo;