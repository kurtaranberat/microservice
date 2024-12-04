# Start Redis
Start-Process "redis-server" -NoNewWindow

# Start all services
Push-Location C:/app/src/frontend
Start-Process "npm" -ArgumentList "start" -NoNewWindow
Pop-Location

Push-Location C:/app/src/cartservice/src
Start-Process "dotnet" -ArgumentList "run" -NoNewWindow
Pop-Location

Push-Location C:/app/src/productcatalogservice
Start-Process "./productcatalogservice.exe" -NoNewWindow
Pop-Location

Push-Location C:/app/src/currencyservice
Start-Process "node" -ArgumentList "server.js" -NoNewWindow
Pop-Location

Push-Location C:/app/src/paymentservice
Start-Process "node" -ArgumentList "index.js" -NoNewWindow
Pop-Location

Push-Location C:/app/src/shippingservice
Start-Process "./shippingservice.exe" -NoNewWindow
Pop-Location

Push-Location C:/app/src/emailservice
Start-Process "python" -ArgumentList "email_server.py" -NoNewWindow
Pop-Location

Push-Location C:/app/src/recommendationservice
Start-Process "python" -ArgumentList "recommendation_server.py" -NoNewWindow
Pop-Location

# Keep the container running
while ($true) { Start-Sleep -Seconds 60 }
