FROM eclipse-temurin:21

# Define environment variables for easy updates
ENV CBLITE_VERSION=3.2.2
ENV CBLITE_URL="https://packages.couchbase.com/releases/couchbase-lite-java/${CBLITE_VERSION}/couchbase-lite-java-linux-supportlibs-${CBLITE_VERSION}.zip"
ENV LIB_DIR="/opt/couchbase-lite"

# Install dependencies and download Couchbase Lite support libraries
RUN apt-get update && apt-get install -y wget unzip && \
    mkdir -p ${LIB_DIR} && \
    wget -O /tmp/couchbase-lite.zip ${CBLITE_URL} && \
    unzip /tmp/couchbase-lite.zip -d ${LIB_DIR} && \
    rm /tmp/couchbase-lite.zip && \
    apt-get clean

# Export the library path
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${LIB_DIR}"