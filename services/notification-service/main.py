import os
from fastapi import FastAPI

app = FastAPI(title="Notification Service")

# SECURE: SMTP Password retrieved from environment variable
SMTP_PASS = os.getenv("SMTP_PASS")

@app.get("/")
def read_root():
    return {"message": "Notification Service is running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
