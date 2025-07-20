#!/bin/bash

# Script para iniciar apenas o Streamlit no Render
echo " Iniciando Streamlit no Render..."

# Configurar PYTHONPATH
export PYTHONPATH=/opt/render/project/src:$PYTHONPATH

# Iniciar Streamlit
streamlit run app_streamlit.py \
    --server.port ${PORT:-8501} \
    --server.address 0.0.0.0 \
    --server.headless true \
    --server.enableCORS false \
    --server.enableXsrfProtection false
