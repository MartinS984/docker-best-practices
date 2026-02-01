// ============================================
// Express Server with Docker Best Practices
// Features:
// - Health checks for Practice 8
// - Graceful shutdown
// - Structured logging
// ============================================

require('dotenv').config();
const express = require('express');

// Create Express application
const app = express();
const PORT = process.env.APP_PORT || 3000;

// ============ HEALTH CHECKS (Practice 8) ============

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    service: 'ecommerce-backend',
    version: '1.0.0',
    environment: process.env.NODE_ENV || 'development'
  });
});

// Sample API endpoint
app.get('/api/v1/products', (req, res) => {
  const products = [
    { id: 1, name: 'Laptop Pro', price: 1299.99, category: 'Electronics' },
    { id: 2, name: 'Wireless Mouse', price: 29.99, category: 'Accessories' },
    { id: 3, name: 'Mechanical Keyboard', price: 89.99, category: 'Accessories' }
  ];
  
  res.json({
    success: true,
    data: products,
    count: products.length,
    timestamp: new Date().toISOString()
  });
});

// ============ GRACEFUL SHUTDOWN ============

// Graceful shutdown handling
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully');
  server.close(() => {
    console.log('Process terminated');
    process.exit(0);
  });
});

// Start server
const server = app.listen(PORT, () => {
  console.log(`
🚀 Server started successfully!
📡 Port: ${PORT}
🌍 Environment: ${process.env.NODE_ENV || 'development'}
⏰ Time: ${new Date().toISOString()}
🔗 Health check: http://localhost:${PORT}/health
  `);
});

// Export for testing
module.exports = app;