
import React, { useState, useEffect } from "react";
<<<<<<< HEAD
=======
import BACKEND_URL from "../config/config";
>>>>>>> c92e127 ( add terraform ansbile github action files)

const TodoApp = () => {
  const [todo, setTodo] = useState("");
  const [todos, setTodos] = useState([]);
  const [loading, setLoading] = useState(false);

// Inline editing states
//  const [editingId, setEditingId] = useState(null);
//  const [editText, setEditText] = useState('');


  // Fetch todos when component mounts
  useEffect(() => {
    console.log("Component mounted, fetching todos...");
    fetchTodos();
  }, []);

  // Fetch all todos from backend
  const fetchTodos = async () => {
    try {
<<<<<<< HEAD
      const response = await fetch('/api/todos'); // ✅ RELATIVE path
=======
      const response = await fetch('${BACKEND_URL}/todos'); // ✅ RELATIVE path fetch('/api/todos');
>>>>>>> c92e127 ( add terraform ansbile github action files)
      console.log("Fetch response status:", response.status);
      if (response.ok) {
        const data = await response.json();
        console.log("Fetched todos:", data);
        setTodos(data);
      } else {
        console.log("Failed to fetch todos:", response.statusText);
      }
    } catch (err) {
      console.log("Error fetching todos:", err);
    }
  };

  // Handle the change in the input field
  const handleChange = (e) => {
    setTodo(e.target.value);
  };

  // Handle form submission to add the todo
  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!todo.trim()) return; // Don't add empty todos
    
    setLoading(true);
    try {
<<<<<<< HEAD
      const response = await fetch('http://localhost:3001/api/add-todo', {
=======
      const response = await fetch('${BACKEND_URL}/add-todo', // ${BACKEND_URL} fetch('http://localhost:3001/api/add-todo'
        {
>>>>>>> c92e127 ( add terraform ansbile github action files)
        method: "POST",
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ todo: todo.trim() })
      });

      if (!response.ok) {
        throw new Error(`Failed to add todo: ${response.statusText}`);
      }

      const data = await response.json();
      console.log("Response received:", data);
      console.log("Current todos before adding:", todos);
      
      // Add new todo to the state - if backend doesn't return the todo, create it locally
      const newTodo = data || { _id: Date.now().toString(), todo: todo.trim(), completed: false };
      setTodos(prevTodos => {
        const updatedTodos = [...prevTodos, newTodo];
        console.log("Updated todos:", updatedTodos);
        return updatedTodos;
      });
      setTodo(""); // Clear input field
    } catch (err) {
      console.log("Error occurred:", err);
    } finally {
      setLoading(false);
    }
  };

  // Handle delete todo
  const handleDelete = async (todoId) => {
    try {
<<<<<<< HEAD
      const response = await fetch(`http://localhost:3001/api/delete-todo/${todoId}`, {
=======
      const response = await fetch(`${BACKEND_URL}/delete-todo/${todoId}`, // fetch(`http://localhost:3001/api/delete-todo/${todoId}`
         {
>>>>>>> c92e127 ( add terraform ansbile github action files)
        method: "DELETE"
      });

      if (!response.ok) {
        throw new Error(`Failed to delete todo: ${response.statusText}`);
      }

      // Remove todo from state
      setTodos(prevTodos => prevTodos.filter(t => t._id !== todoId));
      console.log("Todo deleted successfully");
    } catch (err) {
      console.log("Error deleting todo:", err);
    }
  };

  // Handle toggle complete status
  const handleToggleComplete = async (todoId, currentStatus) => {
    try {
<<<<<<< HEAD
      const response = await fetch(`http://localhost:3001/api/toggle-todo/${todoId}`, {
=======
      const response = await fetch(`${BACKEND_URL}//toggle-todo/${todoId}`, // fetch(`http://localhost:3001/api/toggle-todo/${todoId}`
         {
>>>>>>> c92e127 ( add terraform ansbile github action files)
        method: "PATCH",
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ completed: !currentStatus })
      });

      if (!response.ok) {
        throw new Error(`Failed to toggle todo: ${response.statusText}`);
      }

      // Update todo status in state
      setTodos(prevTodos => 
        prevTodos.map(t => 
          t._id === todoId ? { ...t, completed: !currentStatus } : t
        )
      );
    } catch (err) {
      console.log("Error toggling todo:", err);
    }
  };



  
  const completedCount = todos.filter(t => t.completed).length;

  return (
    <div style={{
      minHeight: '100vh',
      padding: '2rem 1rem',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      fontFamily: "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif"
    }}>
      <div style={{
        maxWidth: '800px',
        margin: '0 auto'
      }}>
        {/* Header */}
        <header style={{
          textAlign: 'center',
          marginBottom: '3rem'
        }}>
          <h1 style={{
            fontSize: '3.5rem',
            color: 'white',
            marginBottom: '0.5rem',
            textShadow: '0 4px 8px rgba(0, 0, 0, 0.3)',
            fontWeight: '700',
            letterSpacing: '-0.02em'
          }}>My Todo App</h1>
          <p style={{
            color: 'rgba(255, 255, 255, 0.8)',
            fontSize: '1.2rem',
            fontWeight: '300'
          }}>Stay organized and get things done</p>
        </header>

        {/* Add Todo Section */}
        <section style={{
          background: 'rgba(255, 255, 255, 0.95)',
          backdropFilter: 'blur(10px)',
          borderRadius: '20px',
          padding: '2rem',
          marginBottom: '2rem',
          boxShadow: '0 20px 40px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.2)'
        }}>
          <div style={{
            display: 'flex',
            gap: '1rem',
            alignItems: 'center',
            flexWrap: 'wrap'
          }}>
            <input
              type="text"
              value={todo}
              placeholder="What needs to be done?"
              onChange={handleChange}
              onKeyDown={(e) => e.key === 'Enter' && handleSubmit(e)}
              style={{
                flex: '1',
                minWidth: '250px',
                padding: '1rem 1.5rem',
                border: '2px solid #e1e5e9',
                borderRadius: '12px',
                fontSize: '1.1rem',
                background: 'white',
                outline: 'none',
                transition: 'all 0.3s ease'
              }}
              disabled={loading}
              onFocus={(e) => {
                e.target.style.borderColor = '#667eea';
                e.target.style.boxShadow = '0 0 0 3px rgba(102, 126, 234, 0.1)';
                e.target.style.transform = 'translateY(-1px)';
              }}
              onBlur={(e) => {
                e.target.style.borderColor = '#e1e5e9';
                e.target.style.boxShadow = 'none';
                e.target.style.transform = 'translateY(0)';
              }}
            />
            <button
              onClick={handleSubmit}
              disabled={loading || !todo.trim()}
              style={{
                padding: '1rem 2rem',
                background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                color: 'white',
                border: 'none',
                borderRadius: '12px',
                fontSize: '1.1rem',
                fontWeight: '600',
                cursor: loading || !todo.trim() ? 'not-allowed' : 'pointer',
                transition: 'all 0.3s ease',
                minWidth: '100px',
                opacity: loading || !todo.trim() ? '0.6' : '1'
              }}
              onMouseEnter={(e) => {
                if (!loading && todo.trim()) {
                  e.target.style.transform = 'translateY(-2px)';
                  e.target.style.boxShadow = '0 10px 25px rgba(102, 126, 234, 0.3)';
                }
              }}
              onMouseLeave={(e) => {
                e.target.style.transform = 'translateY(0)';
                e.target.style.boxShadow = 'none';
              }}
            >
              {loading ? 'Adding...' : 'Add Task'}
            </button>
          </div>
        </section>

        {/* Stats */}
        {todos.length > 0 && (
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            marginBottom: '2rem',
            padding: '1rem 1.5rem',
            background: 'rgba(255, 255, 255, 0.9)',
            backdropFilter: 'blur(10px)',
            borderRadius: '15px',
            boxShadow: '0 10px 20px rgba(0, 0, 0, 0.05)',
            flexWrap: 'wrap',
            gap: '1rem'
          }}>
            <div style={{
              color: '#555',
              fontWeight: '500'
            }}>
              Total Tasks: <span style={{
                fontWeight: '700',
                color: '#667eea',
                marginLeft: '0.5rem'
              }}>{todos.length}</span>
            </div>
            <div style={{
              color: '#555',
              fontWeight: '500'
            }}>
              Completed: <span style={{
                fontWeight: '700',
                color: '#667eea',
                marginLeft: '0.5rem'
              }}>{completedCount}</span>
            </div>
            <div style={{
              color: '#555',
              fontWeight: '500'
            }}>
              Remaining: <span style={{
                fontWeight: '700',
                color: '#667eea',
                marginLeft: '0.5rem'
              }}>{todos.length - completedCount}</span>
            </div>
          </div>
        )}

        {/* Todo List */}
        <main style={{
          display: 'flex',
          flexDirection: 'column',
          gap: '1rem'
        }}>
          {todos.length === 0 ? (
            <div style={{
              textAlign: 'center',
              padding: '4rem 2rem',
              background: 'rgba(255, 255, 255, 0.9)',
              backdropFilter: 'blur(10px)',
              borderRadius: '20px',
              boxShadow: '0 20px 40px rgba(0, 0, 0, 0.08)'
            }}>
              <div style={{
                fontSize: '4rem',
                marginBottom: '1rem'
              }}>📝</div>
              <h3 style={{
                fontSize: '1.5rem',
                color: '#374151',
                marginBottom: '0.5rem',
                fontWeight: '600'
              }}>No tasks yet</h3>
              <p style={{
                color: '#9ca3af',
                fontSize: '1rem'
              }}>Add your first task above to get started!</p>
            </div>
          ) : (
            todos.map((todoItem) => (
              <div
                key={todoItem._id}
                style={{
                  background: 'rgba(255, 255, 255, 0.95)',
                  backdropFilter: 'blur(10px)',
                  borderRadius: '15px',
                  padding: '1.5rem',
                  boxShadow: '0 10px 25px rgba(0, 0, 0, 0.08)',
                  border: todoItem.completed ? '1px solid rgba(34, 197, 94, 0.2)' : '1px solid rgba(255, 255, 255, 0.2)',
                  transition: 'all 0.3s ease',
                  position: 'relative',
                  overflow: 'hidden',
                  opacity: todoItem.completed ? '0.7' : '1'
                }}
                onMouseEnter={(e) => {
                  e.target.style.transform = 'translateY(-3px)';
                  e.target.style.boxShadow = '0 20px 40px rgba(0, 0, 0, 0.12)';
                }}
                onMouseLeave={(e) => {
                  e.target.style.transform = 'translateY(0)';
                  e.target.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.08)';
                }}
              >
                {todoItem.completed && (
                  <div style={{
                    position: 'absolute',
                    top: '0',
                    left: '0',
                    width: '100%',
                    height: '4px',
                    background: 'linear-gradient(90deg, #4ade80, #22c55e)'
                  }}></div>
                )}
                <div style={{
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: '1rem'
                }}>
                  <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '1rem',
                    flex: '1'
                  }}>
                    <button
                      onClick={() => handleToggleComplete(todoItem._id, todoItem.completed)}
                      style={{
                        width: '24px',
                        height: '24px',
                        border: todoItem.completed ? '2px solid #22c55e' : '2px solid #d1d5db',
                        borderRadius: '50%',
                        background: todoItem.completed ? 'linear-gradient(135deg, #22c55e, #16a34a)' : 'white',
                        cursor: 'pointer',
                        transition: 'all 0.3s ease',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        flexShrink: '0',
                        color: todoItem.completed ? 'white' : 'transparent',
                        fontSize: '14px',
                        fontWeight: 'bold'
                      }}
                      title={todoItem.completed ? 'Mark as incomplete' : 'Mark as complete'}
                      onMouseEnter={(e) => {
                        if (!todoItem.completed) {
                          e.target.style.borderColor = '#22c55e';
                        }
                        e.target.style.transform = 'scale(1.1)';
                      }}
                      onMouseLeave={(e) => {
                        if (!todoItem.completed) {
                          e.target.style.borderColor = '#d1d5db';
                        }
                        e.target.style.transform = 'scale(1)';
                      }}
                    >
                      {todoItem.completed ? '✓' : ''}
                    </button>
                    <span style={{
                      fontSize: '1.1rem',
                      color: todoItem.completed ? '#9ca3af' : '#374151',
                      flex: '1',
                      transition: 'all 0.3s ease',
                      textDecoration: todoItem.completed ? 'line-through' : 'none'
                    }}>
                      {todoItem.todo || todoItem.text || todoItem.title}
                    </span>
                  </div>
                  
                  <button
                    onClick={() => handleDelete(todoItem._id)}
                    style={{
                      background: 'none',
                      border: 'none',
                      color: '#ef4444',
                      fontSize: '1.5rem',
                      cursor: 'pointer',
                      padding: '0.5rem',
                      borderRadius: '8px',
                      transition: 'all 0.3s ease',
                      opacity: '0.7'
                    }}
                    title="Delete task"
                    onMouseEnter={(e) => {
                      e.target.style.background = 'rgba(239, 68, 68, 0.1)';
                      e.target.style.opacity = '1';
                      e.target.style.transform = 'scale(1.1)';
                    }}
                    onMouseLeave={(e) => {
                      e.target.style.background = 'none';
                      e.target.style.opacity = '0.7';
                      e.target.style.transform = 'scale(1)';
                    }}
                  >
                    🗑️
                  </button>
                </div>
                
                {todoItem.createdAt && (
                  <div style={{
                    marginTop: '0.5rem',
                    fontSize: '0.85rem',
                    color: '#9ca3af',
                    paddingLeft: '2.5rem'
                  }}>
                    Added: {new Date(todoItem.createdAt).toLocaleDateString('en-US', {
                      month: 'short',
                      day: 'numeric',
                      year: 'numeric'
                    })}
                  </div>
                )}
              </div>
            ))
          )}
        </main>

        {/* Footer */}
        {todos.length > 0 && (
          <footer style={{
            textAlign: 'center',
            marginTop: '3rem',
            padding: '1rem',
            color: 'rgba(255, 255, 255, 0.8)',
            fontSize: '0.9rem'
          }}>
            You're doing great! Keep up the momentum! 🚀
          </footer>
        )}
      </div>
    </div>
  );
};

export default TodoApp;