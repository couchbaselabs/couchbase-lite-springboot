# Couchbase lite +3.1 & Springboot
Couchbase Lite +3.1.1 generic client template &amp; Springboot integration 3.1.2 using Custom Scope &amp; Collections

```cmd
cd quickstart
docker-compose up
```

## Create a `db` database in SGW  

Using scopes/collections: 

```cmd
curl -X PUT "http://localhost:4985/db/" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"name\": \"db\", \"bucket\": \"mobile\", \"scopes\": { \"custom\": { \"collections\": { \"typeA\": { \"sync\": \"function(doc, oldDoc, meta) { if(doc.channels) { channel(doc.destination); }else{ throw({forbidden: \\\"document'\\\"+doc._id+\\\"'doesn't contain channels field to sync\\\"}); } }\" }, \"typeB\": { \"sync\": \"function(doc, oldDoc, meta) { if(doc.channels) { channel(doc.destination); }else{ throw({forbidden: \\\"document'\\\"+doc._id+\\\"'doesn't contain channels field to sync\\\"}); } }\" } } } }, \"revs_limit\": 20, \"allow_conflicts\": false, \"num_index_replicas\": 0}"
```

## Create the `userdb1/password` SGW `db` database user/password

```cmd
curl -u sync_gateway:password -X POST "http://localhost:4985/db/_user/" -H "accept: */*" -H "Content-Type: application/json" -d "{\"name\":\"userdb1\",\"password\":\"password\",\"collection_access\":{\"custom\":{\"typeA\":{\"admin_channels\":[\"blue\"]},\"typeB\":{\"admin_channels\":[\"blue\"]}}},\"email\":\"userdb1@company.com\"}"
```

Here's the **updated README content** with the new section to run the app using `mvnw`, followed by the Jib Docker section.

---

## ▶️ Run the App

### 📦 Using Maven Wrapper

You can start the Spring Boot application directly using the Maven wrapper:

```bash
./mvnw spring-boot:run
```

> This will launch the app on port 8080 by default.

---

### 🐳 Build & Run with Jib (Local Docker)

You can build the Spring Boot application as a Docker image locally using [Jib](https://github.com/GoogleContainerTools/jib) without needing a Dockerfile.

#### 🛠️ Build the image locally
```bash
./mvnw compile jib:dockerBuild
```

This will create a local Docker image named `springboot-couchbase-lite`.

> The image is based on a custom base image: [tayebchlyah/eclipse-temurin-cblite](https://hub.docker.com/r/tayebchlyah/eclipse-temurin-cblite)
> This image includes the required native libraries for Couchbase Lite on Linux, as outlined in the official [Couchbase Lite Java prerequisites](https://docs.couchbase.com/couchbase-lite/current/java/gs-prereqs.html#additional-steps-for-linux) documentation.

#### 🚀 Start the container
```bash
docker run -p 8080:8080 springboot-couchbase-lite
```

> 📝 Make sure Docker is running locally before executing the above commands.