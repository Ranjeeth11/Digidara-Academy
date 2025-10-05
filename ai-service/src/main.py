from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="DigiDARA AI Service", version="1.0.0")

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health_check():
    return {"status": "ok", "message": "AI Service is running"}

@app.post("/answer")
async def answer_question():
    # Stub implementation for Sprint 1
    return {
        "answer": "This is a stub response from the AI service. Full RAG implementation coming soon.",
        "citations": ["Citation 1 (stub)", "Citation 2 (stub)"]
    }

@app.get("/")
async def root():
    return {"message": "DigiDARA AI Service"}