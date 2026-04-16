# 1. n8n-in rəsmi imicindən başlayırıq
FROM n8nio/n8n:latest

# 2. İstifadəçini root edirik ki, hər yerə icazəmiz olsun
USER root

# 3. İş qovluğunu və ev qovluğunu təyin edirik
ENV HOME=/home/node
WORKDIR /home/node

# 4. Qovluqları yaradırıq və mütləq icazələri veririk
RUN mkdir -p /home/node/.n8n && \
    chmod -R 777 /home/node /home/node/.n8n

# 5. Render üçün vacib olan mühit dəyişənləri
ENV PORT=10000
ENV N8N_PORT=10000
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV N8N_USER_MANAGEMENT_DISABLED=true
ENV NODE_OPTIONS="--max-old-space-size=400"

# 6. SİRR BURADADIR: "sh -c" istifadə edərək sistemi məcbur edirik 
# ki, n8n-i harada olursa-olsun özü tapsın və işə salsın
CMD ["sh", "-c", "n8n start"]
