



import Todo from "../Models/Todomodels.js";

export const getTodos = async (req, res) => {
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
};

export const addTodo = async(req, res) => {
  try {
    const todoText = req.body.todo; // Use ('todo') to match React
    console.log('Adding a todo:', todoText);

    const newTodo = new Todo({
      todo: todoText, // Change from 'title' to 'todo'
    });

    console.log('Adding a todo', newTodo);
    const savedTodo = await newTodo.save(); // Save the new todo
    console.log('Added a todo', savedTodo);

    res.status(200).json(savedTodo);
  } catch (err) {
    console.error('Error saving todo:', err);
    res.status(500).json({ error: 'Failed to save todo' });
  }
};

// ADD THESE NEW FUNCTIONS:

export const deleteTodo = async (req, res) => {
  try {
    const { id } = req.params;
    const deletedTodo = await Todo.findByIdAndDelete(id);
    
    if (!deletedTodo) {
      return res.status(404).json({ error: 'Todo not found' });
    }
    
    console.log('Deleted todo:', deletedTodo);
    res.status(200).json({ message: 'Todo deleted successfully' });
  } catch (error) {
    console.error('Error deleting todo:', error);
    res.status(500).json({ error: 'Failed to delete todo' });
  }
};

export const toggleTodo = async (req, res) => {
  try {
    const { id } = req.params;
    const { completed } = req.body;
    
    const updatedTodo = await Todo.findByIdAndUpdate(
      id, 
      { completed }, 
      { new: true }
    );
    
    if (!updatedTodo) {
      return res.status(404).json({ error: 'Todo not found' });
    }
    
    console.log('Toggled todo:', updatedTodo);
    res.status(200).json(updatedTodo);
  } catch (error) {
    console.error('Error toggling todo:', error);
    res.status(500).json({ error: 'Failed to update todo' });
  }
};

