#!/bin/bash

# Script para desenvolvimento local
# Uso: ./dev.sh [start|stop|build|logs]

case "$1" in
    "start")
        echo " Iniciando serviços de desenvolvimento..."
        docker-compose up -d --build
        echo "✅ Serviços iniciados!"
        echo "📱 Streamlit: http://localhost:8501"
        echo "🔧 FastAPI: http://localhost:8000"
        ;;
    "stop")
        echo " Parando serviços..."
        docker-compose down
        echo " Serviços parados!"
        ;;
    "build")
        echo "🔨 Reconstruindo imagens..."
        docker-compose build --no-cache
        echo " Build concluído!"
        ;;
    "logs")
        echo " Mostrando logs dos serviços..."
        docker-compose logs -f
        ;;
    "test")
        echo " Executando testes..."
        docker-compose run --rm ml-recruitment-app pytest tests/
        ;;
    *)
        echo "Uso: $0 {start|stop|build|logs|test}"
        echo ""
        echo "Comandos disponíveis:"
        echo "  start  - Inicia os serviços"
        echo "  stop   - Para os serviços"
        echo "  build  - Reconstrói as imagens"
        echo "  logs   - Mostra os logs"
        echo "  test   - Executa os testes"
        ;;
esac
