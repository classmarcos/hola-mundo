import os

from fastapi import FastAPI

APP_ENV = os.getenv("APP_ENV", "dev")  # nunca "prod" por defecto
APP_VERSION = os.getenv("APP_VERSION", "local")

app = FastAPI(title="Hola Mundo")


@app.get("/")
def hola() -> dict:
    return {"mensaje": "Hola mundo", "ambiente": APP_ENV}


@app.get("/health")
def health() -> dict:
    return {"status": "ok", "version": APP_VERSION}
