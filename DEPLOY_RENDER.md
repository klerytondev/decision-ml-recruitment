# Instruções para Deploy no Render

## Opção 1: Deploy Separado (Recomendado para Plano Gratuito)

### 1. Deploy da API FastAPI

1. Acesse [render.com](https://render.com) e faça login
2. Clique em "New +" → "Web Service"
3. Conecte seu repositório GitHub
4. Configure:
   - **Name**: `ml-recruitment-api`
   - **Environment**: `Python 3`
   - **Build Command**: `./build.sh`
   - **Start Command**: `./start-api.sh`
   - **Instance Type**: `Free`

### 2. Deploy do Streamlit

1. Crie outro "Web Service"
2. Configure:
   - **Name**: `ml-recruitment-streamlit`
   - **Environment**: `Python 3`
   - **Build Command**: `./build.sh`
   - **Start Command**: `./start-streamlit.sh`
   - **Instance Type**: `Free`

3. **Importante**: Adicione variável de ambiente:
   - **Key**: `API_URL`
   - **Value**: `https://ml-recruitment-api.onrender.com` (URL da sua API)

## Opção 2: Deploy com render.yaml (Blueprint)

1. Faça push do arquivo `render.yaml` para seu repositório
2. No Render, clique em "New +" → "Blueprint"
3. Conecte seu repositório e selecione o `render.yaml`

## Limitações do Plano Gratuito

 **Importantes limitações do Render gratuito:**

- Serviços hibernam após 15 minutos de inatividade
- Podem levar 30-60 segundos para "acordar"
- 750 horas/mês por serviço
- Largura de banda limitada

## URLs de Exemplo

Após o deploy, suas URLs serão:
- **API**: https://ml-recruitment-api.onrender.com
- **Streamlit**: https://ml-recruitment-streamlit.onrender.com

## Troubleshooting

### Problemas Comuns:

1. **Build falha**: Verifique se os arquivos de modelo existem em `etl/output/`
2. **Serviço não inicia**: Verifique logs no dashboard do Render
3. **API não responde**: Aguarde alguns segundos - pode estar hibernando

### Verificar Status:

- API Health: `https://ml-recruitment-api.onrender.com/health`
- Streamlit: Acesse diretamente a URL do Streamlit

## Alternativas Gratuitas

Se o Render não funcionar bem, considere:

- **Streamlit Cloud** (apenas para Streamlit apps)
- **Railway** (com créditos gratuitos)
- **Heroku** (plano hobby descontinuado, mas ainda disponível)
- **Vercel** (para apps menores)
