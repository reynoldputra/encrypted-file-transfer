# Base image
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server

# Copy main program
COPY client-cli /home/client-cli
COPY server-api /home/server-api

# Generate SSH keys
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

