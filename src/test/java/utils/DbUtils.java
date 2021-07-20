package utils;

import com.mongodb.*;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import config.AppConfig;
import org.aeonbits.owner.ConfigFactory;
import org.bson.Document;


public class DbUtils {

    AppConfig appConfig = ConfigFactory.create(AppConfig .class);

    public Document getPayload(String actionName) {
        MongoClientURI uri = new MongoClientURI("mongodb://" + appConfig.getDbUserName() + ":" +
                appConfig.getDbPassword() + "@localhost:" + appConfig.getDbPort() + "/" + appConfig.getDbName());
        MongoClient mongoClient = new MongoClient(uri);
        MongoDatabase db = mongoClient.getDatabase("api-news-test");
        MongoCollection<Document> gradesCollection = db.getCollection("payloads");
        Document payload = gradesCollection.find(new Document("actionName", actionName)).first();
        assert payload != null;
        return (Document) payload.get("payload");
    }

}

