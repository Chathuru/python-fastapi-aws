import pytest
from fastapi.testclient import TestClient
from serving.main import app

client = TestClient(app)


def test_get_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Serving App"}


def test_get_status():
    response = client.get("/status")
    assert response.status_code == 200
    data = response.json()
    assert "status" in data
    assert data["status"] in ["NOT_DEPLOYED", "PENDING", "DEPLOYING", "RUNNING"]


def test_get_model_success():
    response = client.get("/model")
    assert response.status_code == 200
    data = response.json()
    assert data["model_id"] == "Sentence-transformers/all-MiniLM-L6-v2"


def test_post_model_success():
    response = client.post("/model")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "success"
    assert data["model_id"] == "Sentence-transformers/all-MiniLM-L6-v2"