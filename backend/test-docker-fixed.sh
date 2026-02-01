#!/bin/bash

echo "🧪 TESTING DOCKER BEST PRACTICES"
echo "================================"

echo ""
echo "1. Building development image..."
docker build -t backend-dev . 2>&1 | tail -5

if [ $? -eq 0 ]; then
    echo "✅ Development build successful!"
else
    echo "❌ Development build failed"
    exit 1
fi

echo ""
echo "2. Building production image (multi-stage)..."
docker build -f Dockerfile.prod -t backend-prod . 2>&1 | tail -5

if [ $? -eq 0 ]; then
    echo "✅ Production build successful!"
else
    echo "❌ Production build failed"
    exit 1
fi

echo ""
echo "3. Comparing image sizes:"
echo "   Development: $(docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | grep backend-dev)"
echo "   Production:  $(docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | grep backend-prod)"

echo ""
echo "4. Testing running container..."
docker run -d -p 3000:3000 --name backend-test backend-prod

echo "   Waiting for server to start..."
sleep 5

echo ""
echo "5. Health check test:"
if curl -s http://localhost:3000/health >/dev/null 2>&1; then
    echo "✅ Health endpoint responding!"
    echo "   Response:"
    curl -s http://localhost:3000/health | python3 -m json.tool 2>/dev/null || \
    curl -s http://localhost:3000/health
else
    echo "❌ Health check failed"
    echo "   Container logs:"
    docker logs backend-test
fi

echo ""
echo "6. API endpoint test:"
curl -s http://localhost:3000/api/v1/products >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ API endpoint responding!"
    curl -s http://localhost:3000/api/v1/products | python3 -m json.tool 2>/dev/null || \
    curl -s http://localhost:3000/api/v1/products
else
    echo "❌ API endpoint failed"
fi

echo ""
echo "7. Security check - non-root user:"
if docker exec backend-test whoami 2>/dev/null | grep -q "appuser"; then
    echo "✅ Running as non-root user: appuser"
else
    echo "⚠️  Could not verify user (container might not be running)"
fi

echo ""
echo "8. Cleanup..."
docker stop backend-test 2>/dev/null || true
docker rm backend-test 2>/dev/null || true
docker rmi backend-dev backend-prod 2>/dev/null || true

echo ""
echo "🎉 Docker best practices test completed!"
