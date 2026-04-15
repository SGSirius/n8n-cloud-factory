FROM n8nio/n8n:latest

USER root

# Lazımi qovluqları yarat və icazələri mütləq node istifadəçisinə ver
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node

# Render-in pulsuz RAM limitini keçməmək üçün yaddaş optimizasiyası
ENV NODE_OPTIONS="--max-old-space-size=400"
ENV PORT=10000
ENV N8N_PORT=10000

# Verilənlər bazası üçün daxili SQLite istifadə etsin
ENV DB_TYPE=sqlite

CMD ["n8n", "start"]
