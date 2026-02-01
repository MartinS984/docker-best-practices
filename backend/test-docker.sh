#!/bin/bash

echo "🧪 TESTING DOCKER BEST PRACTICES"
echo "================================"

echo ""
echo "1. Ensuring package-lock.json exists..."
if [ ! -f "package-lock.json" ]; then
    echo "   Creating package-lock.json..."
    npm install --package-lock-only
fi

echo ""
echo "2. Building images..."
docker build -t backend-dev . 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Development image built successfully"
else
    echo "❌ Development image build failed"
    exit 1
fi

docker build -f Dockerfile.prod -t backend-prod . 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Production image built successfully"
else
    echo "❌ Production image build failed"
    exit 1
fi

echo ""
echo "3. Comparing image sizes:"
dev_size=$(docker images --format "{{.Size}}" backend-dev 2>/dev/null || echo "N/A")
prod_size=$(docker images --format "{{.Size}}" backend-prod 2>/dev/null || echo "N/A")
echo "   Development: $dev_size"
echo "   Production:  $prod_size"

echo ""
echo "4. Testing production image..."
docker run -d -p 3000:3000 --name test-backend backend-prod 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Container started"
    
    # Wait for server to start
    echo "   Waiting for server to start..."
    for i in {1..10}; do
        if curl -s http://localhost:3000/health >/dev/null 2>&1; then
            echo "   Server is responding!"
            break
        fi
        sleep 1
    done
    
    echo ""
    echo "   Health check response:"
    curl -s http://localhost:3000/health | python3 -m json.tool 2>/dev/null || curl -s http://localhost:3000/health
    
    echo ""
    echo "   Testing API endpoint:"
    curl -s http://localhost:3000/api/v1/products | python3 -m json.tool 2>/dev/null || curl -s http://localhost:3000/api/v1/products
    
    echo ""
    echo "   Running as non-root user:"
    docker exec test-backend whoami 2>/dev/null || echo "   Could not check user"
    
    echo ""
    echo "5. Cleanup..."
    docker stop test-backend 2>/dev/null
    docker rm test-backend 2>/dev/null
    
else
    echo "❌ Failed to start container"
fi

# Clean images
docker rmi backend-dev backend-prod 2>/dev/null || true

echo ""
echo "🎉 Docker best practices test completed!"
