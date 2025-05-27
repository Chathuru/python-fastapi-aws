from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Serving App"}


class RoleAssign(BaseModel):
    role: str | None = None
    content: str| None = None


class RequestMessage(BaseModel):
    messages: List[RoleAssign]


@app.post("/completion")
async def completion(messages: RequestMessage):
    try:
        if not messages.messages:
            raise ValueError("List of messages not found")

        for message in messages.messages:
            if not message.role or not message.content:
                raise ValueError("Role or content not found")

        return {"status": "success", "response": [{"role": "assistant", "message": "response"}]}

    except Exception as e:
        print(str(e))  # Optional logging
        return {"status": "error", "message": str(e)}


@app.get("/status")
async def status():
    return {"status": "RUNNING"}


@app.get("/model")
async def get_model():
    return {"model_id": "Sentence-transformers/all-MiniLM-L6-v2"}


@app.post("/model")
async def model():
    try:
        return {"status": "success", "model_id": "Sentence-transformers/all-MiniLM-L6-v2"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

