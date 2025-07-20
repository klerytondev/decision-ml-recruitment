#!/bin/bash

# Script de verificação pré-deploy
echo "🔍 Verificando projeto para deploy no Render..."

# Verificar arquivos essenciais
echo "📋 Verificando arquivos necessários..."

REQUIRED_FILES=(
    "requirements.txt"
    "app_streamlit.py"
    "api/main.py"
    "api_interna/requirements.txt"
    "etl/data/vagas.json"
    "etl/output/modelo_match_xgb.joblib"
    "etl/output/preprocessador_xgb.joblib"
    "etl/output/vetorizador_sim_textual.joblib"
    "etl/output/thresholds_dinamicos.json"
)

MISSING_FILES=()

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        MISSING_FILES+=("$file")
        echo "❌ Arquivo não encontrado: $file"
    else
        echo "✅ $file"
    fi
done

# Verificar scripts de deploy
echo ""
echo "🚀 Verificando scripts de deploy..."

DEPLOY_SCRIPTS=(
    "build.sh"
    "start-api.sh"
    "start-streamlit.sh"
)

for script in "${DEPLOY_SCRIPTS[@]}"; do
    if [ ! -f "$script" ]; then
        echo "❌ Script não encontrado: $script"
    elif [ ! -x "$script" ]; then
        echo "⚠️  Script não executável: $script (rode: chmod +x $script)"
    else
        echo "✅ $script"
    fi
done

# Verificar dependências
echo ""
echo "📦 Verificando dependências..."

if command -v python3 &> /dev/null; then
    echo "✅ Python3 disponível"
    python3 --version
else
    echo "❌ Python3 não encontrado"
fi

# Resumo
echo ""
echo "📊 Resumo da verificação:"

if [ ${#MISSING_FILES[@]} -eq 0 ]; then
    echo "✅ Todos os arquivos necessários estão presentes"
    echo "🚀 Projeto pronto para deploy no Render!"
    echo ""
    echo "Próximos passos:"
    echo "1. Faça commit e push das alterações"
    echo "2. Acesse render.com e crie um novo Web Service"
    echo "3. Siga as instruções em DEPLOY_RENDER.md"
else
    echo "❌ Arquivos em falta: ${#MISSING_FILES[@]}"
    echo "📝 Arquivos necessários antes do deploy:"
    for file in "${MISSING_FILES[@]}"; do
        echo "   - $file"
    done
    echo ""
    echo "💡 Especialmente importante: modelos em etl/output/"
    echo "   Execute os notebooks de treinamento primeiro!"
fi
