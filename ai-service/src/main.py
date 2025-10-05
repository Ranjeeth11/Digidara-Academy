# ai-service/src/main.py
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="DigiDARA AI Service", version="1.0.0")

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class HealthResponse(BaseModel):
    status: str = "ok"
    message: str = "AI Service is running"

class QuestionRequest(BaseModel):
    question: str
    course_id: int

class AnswerResponse(BaseModel):
    answer: str
    citations: list = []

@app.get("/health")
async def health_check() -> HealthResponse:
    return HealthResponse()

@app.post("/answer")
async def answer_question(request: QuestionRequest):
    # Stub implementation for Sprint 1
    return AnswerResponse(
        answer="This is a stub response from the AI service. Full RAG implementation coming soon.",
        citations=["Citation 1 (stub)", "Citation 2 (stub)"]
    )

@app.get("/")
async def root():
    return {"message": "DigiDARA AI Service"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)