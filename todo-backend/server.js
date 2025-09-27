import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import connectionDB from './db.js';
import todoroutes from './routes/todoroutes.js';
import { register, httpRequestDurationSeconds } from './utils/metrics.js';

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


//  Middleware to track request duration
app.use((req, res, next) => {
  const start = process.hrtime();
  res.on('finish', () => {
    const diff = process.hrtime(start);
    const durationInSeconds = diff[0] + diff[1] / 1e9;

    httpRequestDurationSeconds
      .labels(req.method, req.route?.path || req.path, res.statusCode.toString())
      .observe(durationInSeconds);
  });
  next();
});


// Route Mounting
app.use('/api', todoroutes); // <--- All your routes are now under /api

// Basic health route

app.get("/",(req,res)=> {
  res.status(200).json({message:"hello from server"})
})

app.get('/api/test', (req, res) => {
  res.json({ success: true, message: "API is working" });
});

// ✅ Prometheus metrics endpoint
app.get("/metrics", async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});



const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });



  



