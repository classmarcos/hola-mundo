import importlib

from fastapi.testclient import TestClient

from app import main

client = TestClient(main.app)


def test_hola_mundo():
    r = client.get("/")
    assert r.status_code == 200
    assert r.json()["mensaje"] == "Hola mundo"


def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    assert r.json()["status"] == "ok"


def test_ambiente_por_defecto_es_dev(monkeypatch):
    monkeypatch.delenv("APP_ENV", raising=False)
    importlib.reload(main)
    assert main.APP_ENV == "dev"
