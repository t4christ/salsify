FROM php:7.4-apache

# Create a non-root user (change "1001" to your desired user and group IDs)
RUN useradd -u 1001 -g www-data -m salsify

# Set the working directory to /var/www/html
WORKDIR /var/www/html

COPY salsify-php-port.conf  /etc/apache2/ports.conf 

RUN apt-get update && apt-get install -y \
    zip \
    unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && composer require slim/slim && composer require slim/psr7 && composer require nyholm/psr7

# Copy the current directory contents into the container at /var/www/html
COPY index.php .

# Change the ownership of application files to the non-root user
RUN chown -R salsify:www-data .

# Expose port 80 for Apache
EXPOSE 8080

# Switch to the non-root user
USER salsify

# Start Apache web server
CMD ["apache2-foreground"]