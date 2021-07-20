package config;

import org.aeonbits.owner.Config;

@Config.LoadPolicy(Config.LoadType.MERGE)
@Config.Sources({
        "file:src/test/java/config/${JAVA_ENV}.properties",
        "file:src/test/java/config/default.properties",
        "system:properties",
        "system:env"
})

public interface AppConfig extends Config {

    @Key("BACKOFFICE_EMAIL")
    String getBackOfficeEmail();

    @Key("BACKOFFICE_PASSWORD")
    String getBackOfficePassword();

    @Key("API_NEWS_HOST")
    String getApiNewsHost();

    @Key("API_AUTH_HOST")
    String getApiAuthHost();

    @Key("API_FILES_HOST")
    String getApiFilesHost();

    @Key("DB_USERNAME")
    String getDbUserName();

    @Key("DB_PASSWORD")
    String getDbPassword();

    @Key("DB_PORT")
    String getDbPort();

    @Key("DB_NAME")
    String getDbName();

    @Key("MONGO_CONNECTION_URL")
    String getMongoConnectionURL();


}
