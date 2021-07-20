package config;

import org.aeonbits.owner.ConfigFactory;

public class Conf {

    final AppConfig envConfig = ConfigFactory.create(AppConfig.class);

    public String getEnvVariableValueByName(String envVariable) {
        String variableValue;
        String number = envConfig.getBackOfficeEmail();
        System.out.println(number);
        System.out.print("BACKOFFICE_EMAIL " + envConfig.getBackOfficeEmail());
        System.out.println("BACKOFFICE_PASSWORD " + envConfig.getBackOfficePassword());
        System.out.println("API_AUTH_HOST " + envConfig.getApiAuthHost());
        System.out.println("API_NEWS_HOST " + envConfig.getApiNewsHost());
        switch (envVariable) {
            case "BACKOFFICE_EMAIL" -> variableValue = envConfig.getBackOfficeEmail();
            case "BACKOFFICE_PASSWORD" -> variableValue = envConfig.getBackOfficePassword();
            case "API_AUTH_HOST" -> variableValue = envConfig.getApiAuthHost();
            case "API_NEWS_HOST" -> variableValue = envConfig.getApiNewsHost();
            case "API_FILES_HOST" -> variableValue = envConfig.getApiFilesHost();
            default -> throw new IllegalArgumentException("Content not found");
        }
        return variableValue;
    }
}
