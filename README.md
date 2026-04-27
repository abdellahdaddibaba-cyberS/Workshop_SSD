# SecureShop: DevSecOps Microservices Project

SecureShop is a lightweight e-commerce platform based on a microservices architecture, designed to demonstrate DevSecOps practices.

## System Architecture

The system consists of six microservices coordinated via an Nginx API Gateway:

1.  **User Service (Node.js)**: Registration, login (JWT), profile management.
2.  **Product Service (Python)**: Product catalogue, search, categories.
3.  **Order Service (Node.js)**: Cart management, order lifecycle.
4.  **Payment Service (Python)**: Payment initiation, transaction records.
5.  **Notification Service (Node.js)**: Email/SMS dispatch.
6.  **Inventory Service (Python)**: Stock levels, reservation, release.

## Repository Structure

```text
/services
  /user-service         # Node.js
  /product-service      # Python
  /order-service        # Node.js
  /payment-service      # Python
  /notification-service  # Node.js
  /inventory-service    # Python
/gateway                # Nginx configuration
docker-compose.yml      # Local orchestration
.github/workflows       # CI/CD pipelines (SAST, DAST, etc.)
```

## Security Features (Step 2 - SAST)

This project implements Static Application Security Testing (SAST) using:
- **Bandit**: Specifically for Python security anti-patterns.
- **Semgrep**: Multi-language security analysis (Node.js & Python).
