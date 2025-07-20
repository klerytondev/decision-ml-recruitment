FROM python:3.11

# Define diretório de trabalho
WORKDIR /app

# Copia arquivos de dependências primeiro (para cache de layers)
COPY requirements.txt /app/
COPY api_interna/requirements.txt /app/api_interna/
COPY api_interna/pyproject.toml /app/api_interna/

# Atualiza o pip
RUN pip install --upgrade pip

# Instala dependências principais do Streamlit
RUN pip install -r requirements.txt

# Instala dependências da FastAPI
WORKDIR /app/api_interna
RUN pip install -r requirements.txt
RUN pip install -e .

# Volta para a raiz e copia o resto do projeto
WORKDIR /app
COPY . /app/

# Copia e habilita o script de start
RUN chmod +x /app/start.sh

# Expõe as portas usadas pelos dois apps
EXPOSE 8000 8501

# Executa os dois apps
CMD ["/app/start.sh"]
