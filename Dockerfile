FROM n8nio/n8n:latest

USER root

# Lazımi qovluqları yarat və icazələri ver
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

USER node

# n8n-in portunu müəyyən et (Render üçün vacibdir)
ENV PORT=10000
EXPOSE 10000

CMD ["n8n", "start"]
