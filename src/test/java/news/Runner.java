package news;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;
import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


class Runner {

    @Test
    void runNewsTests() {
        Results results = com.intuit.karate.Runner.path("classpath:news/checkEsports.feature",
                "classpath:news/checkGames.feature",
                "classpath:news/CheckImage.feature",
                "classpath:news/checkMatchPredictionAndAnalysis.feature",
                "classpath:news/checkPlayers.feature",
                "classpath:news/checkPublishArticle.feature",
                "classpath:news/checkPublishArticleFunctionality.feature",
                "classpath:news/checkSettings.feature",
                "classpath:news/checkSports.feature",
                "classpath:news/checkTeams.feature",
                "classpath:news/checkTournaments.feature"
                )
                .tags("~@ignore")
                .outputCucumberJson(true)
                .parallel(1);
        generateReport(results.getReportDir());
    }

    public static void generateReport(String karateOutPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add((file.getAbsolutePath())));
        Configuration config = new Configuration(new File("target"), "myproject");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}


