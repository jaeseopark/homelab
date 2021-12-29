FROM jaymoulin/transmission:latest

COPY run.sh ./
RUN chmod +x run.sh

# Remove DOS newline
RUN sed -i 's/\r$//' entrypoint.sh
