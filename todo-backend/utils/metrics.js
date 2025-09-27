import client from 'prom-client';

// Create a Registry to register all metrics
const register = new client.Registry();

// Collect default metrics (CPU, memory, etc.)
client.collectDefaultMetrics({ register });

// Histogram to track HTTP request durations
const httpRequestDurationSeconds = new client.Histogram({
  name: 'http_request_time_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.1, 0.5, 1, 2, 5],
})

const todoMetrics = {
    todoCount: new client.Gauge({
        name: "todo_items_total",
        help: "Total number of todo items"
    }),
    todoAddedTotal: new client.Counter({
        name: "todo_items_added_total",
        help: "Todo items added"
    })
}

// Register the custom histogram
register.registerMetric(httpRequestDurationSeconds);

Object.values(todoMetrics).forEach(metric => {
    console.log("registering metric", metric)
    register.registerMetric(metric)
});

// Export everything you need in server.js
export {
  register,
  httpRequestDurationSeconds,
   todoMetrics,
};
