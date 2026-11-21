
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def home():
    return {
        "message": "AI Model API is running",
        "version": "1.0"
    }

@app.get("/predict")
def predict():
    return {
        "prediction": "Positive",
        "model": "AI Classification Model"
    }
