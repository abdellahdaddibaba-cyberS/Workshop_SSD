import os
from fastapi import FastAPI

app = FastAPI(title="Order Service")

# SECURE: RabbitMQ credentials retrieved from environment variables
RABBITMQ_USER = os.getenv("RABBITMQ_USER")
RABBITMQ_PASS = os.getenv("RABBITMQ_PASS")

@app.get("/")
def read_root():
    return {"message": "Order Service is running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
