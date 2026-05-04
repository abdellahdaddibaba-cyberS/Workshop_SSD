# Run Bandit locally on all services
# Ensure bandit is installed: pip install bandit

echo "Running Bandit on Python services..."
bandit -r services/user-service services/order-service services/notification-service services/inventory-service
