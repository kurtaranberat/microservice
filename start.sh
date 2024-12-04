#!/bin/bash

# Start Redis
redis-server &

# Start all services
cd /app/src/frontend && npm start &
cd /app/src/cartservice/src && dotnet run &
cd /app/src/productcatalogservice && ./productcatalogservice &
cd /app/src/currencyservice && node server.js &
cd /app/src/paymentservice && node index.js &
cd /app/src/shippingservice && ./shippingservice &
cd /app/src/emailservice && python email_server.py &
cd /app/src/recommendationservice && python recommendation_server.py &
cd /app/src/adservice && java -jar build/libs/adservice.jar &

# Keep container running
tail -f /dev/null
