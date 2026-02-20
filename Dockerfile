# Use the official MySQL image
FROM mysql:8.0

# Set a root password (required by MySQL)
ENV MYSQL_ROOT_PASSWORD=root

# Expose MySQL default port
EXPOSE 3306
