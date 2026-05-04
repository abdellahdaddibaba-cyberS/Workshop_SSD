# SecureShop DevSecOps Workshop

## Overview
SecureShop is a microservices-based e-commerce platform designed to demonstrate DevSecOps practices.

## Repository Structure
- `services/`: Source code for the 6 microservices.
- `gateway/`: API Gateway (Nginx).
- `docker-compose.yml`: Orchestration file for local development.

## Services
| Service | Language | Port (Internal) |
|---------|----------|-----------------|
| User | Python | 8001 |
| Product | Node.js | 8002 |
| Order | Python | 8003 |
| Payment | Node.js | 8004 |
| Notification | Python | 8005 |
| Inventory | Python | 8006 |

## How to Run
1. Ensure Docker and Docker Compose are installed.
2. Run `docker-compose up --build`.
3. The API Gateway will be available at `http://localhost:8080`.
