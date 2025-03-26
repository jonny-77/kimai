# Offizielles Kimai Docker-Image verwenden
FROM kimai/kimai2:apache

# Setze das Arbeitsverzeichnis
WORKDIR /opt/kimai

# Kopiere alle Dateien in das Container-Dateisystem
COPY . .

# Set Apache DocumentRoot to /opt/kimai/public
ENV APACHE_DOCUMENT_ROOT /opt/kimai/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf



RUN mkdir -p public/avatars public/thumbnail /opt/kimai/public/var /opt/kimai/var

# Setze die Dateiberechtigungen
RUN chown -R www-data:www-data /opt/kimai/var /opt/kimai/public/avatars /opt/kimai/public/thumbnail /opt/kimai/public/var

# Exponiere Port 8001
EXPOSE 8001

# Starte den Apache-Server
CMD ["apache2-foreground"]
