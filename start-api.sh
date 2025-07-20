#!/bin/bash

# Script para iniciar apenas a API FastAPI no Render
echo " Iniciando FastAPI no Render..."

# Configurar PYTHONPATH
export PYTHONPATH=/opt/render/project/src:$PYTHONPATH

# Iniciar API
uvicorn api.main:vApp --host 0.0.0.0 --port ${PORT:-8000}
