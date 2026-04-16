# 1. n8n-in rəsmi imicindən başlayırıq
FROM n8nio/n8n:latest

# 2. Bütün əməliyyatları root olaraq edirik
USER root

# 3. ƏN VACİB HİSSƏ: Sistemin bütün vacib qovluqlarını PATH-ə əllə əlavə edirik.
# Bu, "Command not found" xətalarını kökündən öldürür.
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# 4. Render üçün port və yaddaş ayarları
ENV PORT=10000
ENV N8N_PORT=10000
ENV NODE_OPTIONS="--max-old-space-size=420"

# 5. Qovluq quruluşunu sadələşdiririk (Nesting xətasını düzəltmək üçün)
ENV N8N_USER_FOLDER=/home/node
RUN mkdir -p /home/node/.n8n && \
    chmod -R 777 /home/node

# 6. İş sahəsini təyin edirik
WORKDIR /home/node

# 7. Imicin daxili ENTRYPOINT-ini tamamilə sıfırlayırıq
ENTRYPOINT []

# 8. n8n-i heç bir shell (sh) istifadə etmədən, birbaşa ikili proqram kimi çağırırıq
CMD ["n8n", "start"]
