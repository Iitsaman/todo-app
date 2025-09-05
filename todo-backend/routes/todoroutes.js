
import express from 'express';
import { getTodos, addTodo, deleteTodo, toggleTodo } from "../Controllers/todocontrollers.js"

const router = express.Router();

// Frontend expects /api/todos (not /api/get-todos)
router.get('/todos', getTodos);

// Your existing add route is correct
router.post('/add-todo', addTodo);

// Add these new routes
router.delete('/delete-todo/:id', deleteTodo);
router.patch('/toggle-todo/:id', toggleTodo); // optional

router.get("/health", (req,res)=>{
    try{
    return res.status(200).json({ msg:"Healthy"})
    }
    catch(err){
        return res.status(500).json({ msg:"Un Healthy"})
    }
})


export default router;