import os
from fastapi import FastAPI

app = FastAPI(title="User Service")

# SECURE: JWT Secret is retrieved from environment variable at runtime
JWT_SECRET = os.getenv("JWT_SECRET")

@app.get("/")
def read_root():
    return {"message": "User Service is running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
