FROM wordpress:6.1-apache

RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
