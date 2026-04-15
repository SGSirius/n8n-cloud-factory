FROM n8nio/n8n:latest

USER root

# Lazımi qovluqları yarat və icazələri ver
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

USER node

# n8n-in sistemdəki tam yolunu (path) göstəririk
ENV PATH=$PATH:/home/node/.npm-global/bin
ENV NODE_OPTIONS="--max-old-space-size=400"
ENV PORT=10000
ENV N8N_PORT=10000

# Əmri tam ünvanla icra edirik ki, "not found" deməsin
CMD ["node", "/usr/local/lib/node_modules/n8n/bin/n8n", "start"]
