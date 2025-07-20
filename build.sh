#!/bin/bash

# Build script para Render
echo " Iniciando build para Render..."

# Atualizar pip
pip install --upgrade pip

# Instalar dependências principais
echo " Instalando dependências principais..."
pip install -r requirements.txt

# Instalar dependências da API interna
echo " Instalando API interna..."
cd api_interna
pip install -r requirements.txt
pip install -e .
cd ..

# Verificar se os modelos existem
echo " Verificando artefatos do modelo..."
if [ ! -f "etl/output/modelo_match_xgb.joblib" ]; then
    echo " Modelo não encontrado em etl/output/"
    echo " Você pode precisar baixar os modelos ou treinar novamente"
fi

echo " Build concluído!"
