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
git clone https://github.com/MartinS984/docker-best-practices.git
cd docker-best-practices
Step 2: Environment Setup
bash
cp .env.example .env
# Edit .env with your configuration
Step 3: Start Services
bash
docker-compose up --build -d
Step 4: Verify Services
bash
docker-compose ps
curl http://localhost:3000/health
curl http://localhost:8080
Step 5: Access Applications
Frontend: http://localhost:8080

Backend API: http://localhost:3000

Health Check: http://localhost:3000/health

🧪 Testing
Validate Configuration
bash
docker-compose config
Run Tests
bash
./scripts/test/compose-test.sh
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

Features: Persistent data storage

🏗️ Development Workflow
Start Development
bash
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d
View Logs
bash
docker-compose logs -f
Stop Services
bash
docker-compose down
Rebuild Services
bash
docker-compose build --no-cache
🛠️ Useful Commands
bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Check status
docker-compose ps

# Execute in container
docker-compose exec backend sh

# Rebuild images
docker-compose build

# Remove unused resources
docker system prune
🆘 Troubleshooting
Port Already in Use
bash
sudo lsof -i :3000
# Change port in docker-compose.yml from "3000:3000" to "3001:3000"
Docker Build Failing
bash
docker system prune -a
docker-compose build --no-cache
Permission Issues
bash
sudo chown $USER:$USER ~/.docker -R
sudo chmod g+rwx ~/.docker -R
Container Won't Start
bash
docker-compose logs backend
docker-compose ps
docker-compose down
docker-compose up -d
🔒 Security Best Practices
Never commit .env files

Use .env.example as template

Run containers as non-root users

Use minimal base images

Regular security updates

Use internal Docker networks

Expose only necessary ports

Implement health checks

📈 Performance Tips
Layer caching in Dockerfiles

Multi-stage builds for production

Resource limits in production

Volume optimization for development

🤝 Contributing
Fork the repository

Create a feature branch

Add tests for new functionality

Submit a Pull Request

📝 License
MIT License

🔗 Resources
Docker Documentation

Docker Compose Documentation

Docker Security Best Practices

📧 Support
For support, open an issue in the GitHub repository.

Maintained by: Martin S
GitHub: https://github.com/MartinS984/docker-best-practices
Last Updated: 2024-02-02