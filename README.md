
# 🚀 Datathon Pós-Tech: Machine Learning Engineering - Recrutamento com IA

👨‍💻 Equipe

Kleryton de Souza, Lucas Paim, Maiara Giavoni, Rafael Tafelli

# Decision Match Predictor - IA para Recrutamento Inteligente

Este projeto utiliza técnicas de Machine Learning para prever o "match" entre candidatos e vagas reais da empresa **Decision**, especializada em recrutamento no setor de TI.

---

## 📌 Visão Geral

- O objetivo é automatizar parte do processo seletivo, ajudando hunters a identificar candidatos com maior potencial de contratação.
- O modelo é treinado com dados históricos (candidatos, vagas e prospects) e considera múltiplas features estruturadas e textuais.
- O app em **Streamlit** permite testar novos candidatos de forma interativa.

---

## 🧱 Estrutura do Projeto

```
├── app_streamlit.py                # Interface interativa para inferência do modelo (RAIZ)
├── requirements.txt                # Dependências principais do projeto
├── Dockerfile                      # Configuração Docker otimizada
├── docker-compose.yml              # Orquestração dos serviços
├── start.sh                        # Script de inicialização dos serviços
├── api/                            # API FastAPI
├── api_interna/                    # Módulo interno de ML
├── etl/
│   ├── notebooks/                  # Notebooks de desenvolvimento
│   │   ├── etl_dataset_match.ipynb         # Construção do dataset
│   │   ├── modelo.ipynb                    # Pipeline de treinamento
│   │   └── ...                             # Outros notebooks
│   ├── output/                     # Artefatos gerados
│   │   ├── modelo_match_xgb.joblib         # Modelo treinado (XGBoost)
│   │   ├── preprocessador_xgb.joblib       # Pipeline de pré-processamento
│   │   ├── vetorizador_sim_textual.joblib  # Vetorizar TF-IDF
│   │   └── ...                             # Outros artefatos
│   └── data/                       # Dados originais
│       ├── vagas.json
│       ├── applicants.json
│       └── prospects.json
└── tests/                          # Testes automatizados
```

---

## 🚀 Como Executar

### Opção 1: Docker (Recomendado)

#### Usando Docker Compose
```bash
# Construir e executar os serviços
docker-compose up --build

# Executar em background
docker-compose up -d --build
```

#### Usando Docker diretamente
```bash
# Construir a imagem
docker build -t ml-recruitment .

# Executar o container
docker run -p 8000:8000 -p 8501:8501 ml-recruitment
```

**Serviços disponíveis:**
- Streamlit App: http://localhost:8501
- FastAPI: http://localhost:8000

### Opção 2: Execução Local

#### 1. Instalar Dependências
```bash
# Dependências principais
pip install -r requirements.txt

# Dependências da API interna
cd api_interna
pip install -r requirements.txt
pip install -e .
cd ..
```

#### 2. Executar os Serviços

**Terminal 1 - FastAPI:**
```bash
uvicorn api.main:vApp --host 0.0.0.0 --port 8000
```

**Terminal 2 - Streamlit:**
```bash
streamlit run app_streamlit.py --server.port=8501 --server.address=0.0.0.0
```

---
## 📊 O que o modelo considera?

- Nível profissional, inglês, espanhol, acadêmico e local (vaga vs candidato)
- Similaridade textual entre os requisitos da vaga e o currículo
- Feature de similaridade ponderada (peso 0.3) para evitar overfitting em texto

---

## 🔍 Testes com Casos Reais

- Os **10 cargos mais populares** foram selecionados com base nas candidaturas.
- Para cada vaga, foi salvo:
  - 1 exemplo real de **match**
  - 1 exemplo real de **não-match**
- Esses dados estão em `etl/output/exemplos_para_teste_app.json`.

---

## 🛠️ Desenvolvimento

### Estrutura dos Serviços
- **FastAPI**: API para predições ML (porta 8000)
- **Streamlit**: Interface de usuário interativa (porta 8501)
- **API Interna**: Módulo de ML como pacote Python

### Comandos Úteis

```bash
# Parar os serviços Docker
docker-compose down

# Ver logs dos serviços
docker-compose logs -f

# Reconstruir apenas se necessário
docker-compose up --build

# Executar apenas um serviço específico
docker-compose up ml-recruitment-app
```

---

## 🧪 Testes

```bash
# Executar todos os testes
pytest

# Executar testes específicos
pytest tests/test_api_main.py
pytest tests/test_ml_recruitment.py
```

---