# Docker Best Practices Project 🐳

A comprehensive demonstration of Docker and Docker Compose best practices for multi-service applications.

## 📁 Project Structure
docker-best-practices/
├── backend/ # Node.js backend API service
│ ├── src/ # Source code
│ ├── tests/ # Backend tests
│ ├── Dockerfile # Development Dockerfile
│ ├── Dockerfile.prod # Production Dockerfile
│ └── package.json # Dependencies
├── frontend/ # Frontend application (NGINX)
│ ├── Dockerfile # Frontend Dockerfile
│ └── index.html # Frontend entry point
├── nginx/ # Custom NGINX configurations
├── postgres/ # PostgreSQL database configuration
├── worker/ # Background worker service
├── analytics/ # Analytics services
├── monitoring/ # Monitoring stack
├── scripts/ # Utility scripts
│ ├── dev/ # Development scripts
│ ├── prod/ # Production scripts
│ ├── test/ # Testing scripts
│ └── utils/ # Utility scripts
├── tests/ # Integration and E2E tests
├── docker-compose.yml # Base Docker Compose configuration
├── docker-compose.dev.yml # Development overrides
├── docker-compose.prod.yml # Production overrides
├── .env.example # Environment variables template
├── .dockerignore # Docker ignore patterns
├── .gitignore # Git ignore patterns
└── README.md # This file

text

## 🚀 Quick Start

### Prerequisites
- Docker Engine 20.10+
- Docker Compose v2.0+
- Git

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd docker-best-practices
Step 2: Environment Setup
bash
# Copy environment template
cp .env.example .env

# Edit the .env file with your configuration
nano .env  # or use your preferred editor
Step 3: Start Services
bash
# For development environment
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d

# Or using the start script
./scripts/dev/start.sh
Step 4: Verify Services
bash
# Check if services are running
docker-compose ps

# Test backend health
curl http://localhost:3000/health

# Test frontend
curl http://localhost:8080
Step 5: Access Applications
Frontend: http://localhost:8080

Backend API: http://localhost:3000

Backend Health: http://localhost:3000/health

🧪 Testing
Test Docker Compose Configuration
bash
./scripts/test/compose-test.sh
Run All Tests
bash
./scripts/test/test-all.sh
Smoke Test (Quick Verification)
bash
./scripts/test/smoke-test.sh
🔧 Service Details
Backend Service
Port: 3000

Health Endpoint: /health

Technology: Node.js + Express

Features: REST API, authentication, business logic

Frontend Service
Port: 8080

Technology: NGINX serving static files

Features: Web interface, API integration

Database Service
Port: 5432 (internal only)

Technology: PostgreSQL

Features: Persistent data storage, migrations

Monitoring Stack
Components: Prometheus, Grafana

Features: Metrics collection, dashboards, alerting

🏗️ Development Workflow
Starting Development Environment
bash
# Build and start with development configuration
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build

# Start in background
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# View logs
docker-compose logs -f
Stopping Services
bash
# Stop and remove containers
docker-compose down

# Stop without removing volumes
docker-compose down --volumes
Rebuilding Services
bash
# Rebuild specific service
docker-compose build backend

# Rebuild all services
docker-compose build --no-cache
📊 Monitoring & Logging
View Logs
bash
# View all logs
docker-compose logs

# Follow logs in real-time
docker-compose logs -f

# View specific service logs
docker-compose logs backend
Check Service Health
bash
# View container status
docker-compose ps

# Check health status
docker-compose exec backend curl localhost:3000/health
🔒 Security Best Practices
Environment Variables
Never commit .env files

Use .env.example as a template

Store sensitive data in environment variables

Docker Security
Run containers as non-root users

Use minimal base images

Regular security updates

Network Security
Use internal Docker networks

Expose only necessary ports

Implement health checks

🛠️ Useful Commands
Docker Compose Commands
bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Execute command in container
docker-compose exec backend sh

# View container status
docker-compose ps

# Rebuild images
docker-compose build

# Pull latest images
docker-compose pull
Docker Commands
bash
# List containers
docker ps

# List images
docker images

# Remove unused resources
docker system prune

# View disk usage
docker system df
🆘 Troubleshooting
Common Issues
1. Port Already in Use
bash
# Check what's using the port
sudo lsof -i :3000

# Change port in docker-compose.yml
# Update: "3000:3000" to "3001:3000"
2. Docker Build Failing
bash
# Clear Docker cache
docker system prune -a

# Rebuild with no cache
docker-compose build --no-cache
3. Permission Issues
bash
# Fix Docker socket permissions
sudo chown $USER:$USER ~/.docker -R
sudo chmod g+rwx ~/.docker -R
4. Container Won't Start
bash
# Check container logs
docker-compose logs backend

# Inspect container
docker-compose ps
docker inspect <container_id>

# Restart services
docker-compose down
docker-compose up -d
Debug Commands
bash
# Enter running container
docker-compose exec backend sh

# Inspect container details
docker inspect <container_id>

# Check resource usage
docker stats

# View Docker events
docker events
📈 Performance Tips
Layer Caching: Optimize Dockerfile for better layer caching

Multi-stage Builds: Use for production to reduce image size

Resource Limits: Set memory and CPU limits in production

Volume Optimization: Use named volumes for better performance

🤝 Contributing
Fork the repository

Create a feature branch (git checkout -b feature/amazing-feature)

Commit your changes (git commit -m 'Add amazing feature')

Push to the branch (git push origin feature/amazing-feature)

Open a Pull Request

📝 License
This project is licensed under the MIT License - see the LICENSE file for details.

🔗 Resources
Docker Documentation

Docker Compose Documentation

Docker Security Best Practices

Node.js Docker Best Practices

📧 Support
For support, email your-email@example.com or open an issue in the GitHub repository.

Maintained by: [Your Name/Team]
Last Updated: $(date +"%Y-%m-%d")
EOF