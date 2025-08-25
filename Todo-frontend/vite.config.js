
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    // For local dev: proxy API requests to backend server on localhost
    proxy: {
      '/api': 'http://localhost:3001',
    },
  },
});
