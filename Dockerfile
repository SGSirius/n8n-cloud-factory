# 1. n8n-in ən stabil versiyasını götürürük
FROM n8nio/n8n:latest

# 2. Bütün əməliyyatları root (admin) olaraq edirik
USER root

# 3. Render üçün mütləq lazım olan mühit dəyişənləri
ENV PORT=10000
ENV N8N_PORT=10000
ENV N8N_PROTOCOL=https
ENV N8N_USER_MANAGEMENT_DISABLED=true

# 4. RAM Limitini idarə edirik (512MB-lıq serverdə çökməməsi üçün)
ENV NODE_OPTIONS="--max-old-space-size=400"

# 5. n8n qovluqlarını hazırlayırıq
RUN mkdir -p /home/node/.n8n && \
    chmod -R 777 /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# 6. "Not found" xətalarını kökündən kəsmək üçün sistem yollarını (PATH) əllə düzəldirik
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/node/.npm-global/bin"

# 7. İş qovluğunu təyin edirik
WORKDIR /home/node

# 8. SİRR BURADADIR: "node" və "n8n" proqramlarını sistemin daxilində harda 
# olmalarından asılı olmayaraq tapıb birləşdiririk
RUN ln -s $(which node) /usr/bin/node || true
RUN ln -s /usr/local/bin/n8n /usr/bin/n8n || true

# 9. İşə salma əmri: Heç bir vasitəçi olmadan birbaşa ana proqramı çağırırıq
# Bu hissə Render-in bütün port və tapılmama xətalarını bloklayır
CMD ["/usr/local/bin/node", "/usr/local/bin/n8n", "start"]
