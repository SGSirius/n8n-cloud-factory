# 1. Ən stabil və son n8n imicini götürürük
FROM n8nio/n8n:latest

# 2. Bütün əməliyyatları root (admin) olaraq edirik ki, "permission denied" xətası olmasın
USER root

# 3. Render üçün mühit dəyişənlərini (environment variables) bura "mıxlayırıq"
# Bu hissə Render panelində yazdıqlarımızı sığortalayır
ENV PORT=10000
ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https
ENV N8N_USER_MANAGEMENT_DISABLED=true

# 4. RAM Limitini idarə edirik (512MB-lıq serverdə çökməməsi üçün)
ENV NODE_OPTIONS="--max-old-space-size=400"

# 5. n8n üçün lazım olan qovluqları yaradırıq və icazələri tam açırıq
RUN mkdir -p /home/node/.n8n && \
    chmod -R 777 /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# 6. n8n-in sistemdəki yerini Render-ə tanıtmaq üçün PATH-i genişləndiririk
ENV PATH=$PATH:/usr/local/lib/node_modules/n8n/bin:/usr/local/bin

# 7. İş sahəsini təyin edirik
WORKDIR /home/node

# 8. Ən əsas hissə: "Not found" xətasını öldürmək üçün tam bir başlanğıc skripti yazırıq
# Bu əmr həm node-u, həm də n8n-i sistemin dərininlərindən tapıb çıxaracaq
ENTRYPOINT []
CMD ["sh", "-c", "export N8N_BINARY=$(which n8n) && if [ -z \"$N8N_BINARY\" ]; then N8N_BINARY='/usr/local/bin/n8n'; fi; node $N8N_BINARY start"]
