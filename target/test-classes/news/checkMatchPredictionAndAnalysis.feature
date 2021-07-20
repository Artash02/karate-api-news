Feature: Check Match Prediction And Analysis Functionality

  Background:

    Given def currentTimeStamp = function() { return java.lang.System.currentTimeMillis() + '' }
    Given def payload =
  """
  function(actionName) {
    var dbUtils = Java.type('utils.DbUtils');
    var payload = new dbUtils();
    return payload.getPayload(actionName);
  }
  """

    Given def addMatchPredictionAnalysis = call payload 'match-prediction-and-analysis'
    Given def editMatchPredictionAnalysis = call payload 'add-match-prediction'
    Given def createArticlePayload = call payload 'create-article'
    Given def addChannelPayload = call payload 'add-channel'
    Given def emptyGamesPayload = call payload 'empty-tags'

  Scenario: 1. Create Article, 2. Add Match Prediction And Analysis 3. Edit Match Prediction And Analysis, 4. Delete Match Prediction And Analysis, 5. Delete created Article

  ##  Create Article

    Given def userInfo = call read('file:src/test/java/helper/get-user-info.feature')
    Given url api_news_host + '/api/news'
    And header authorization = 'Bearer ' + access_token
    And def articleName = 'article_title_api_test' + currentTimeStamp()
    And set createArticlePayload.title = articleName
    Given request createArticlePayload
    When method post
    Then status 201
    And def articleId = response.newsId

##  Add Winners.net Channel

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addChannelPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Add Match Prediction And Analysis

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addMatchPredictionAnalysis
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].type == '#string'
    Then match response.tags[0].color == '#string'

    Then match response.tags[1].channel == '#string'
    Then match response.tags[1].name == '#string'
    Then match response.tags[1].resourceId == '#string'
    Then match response.tags[1].type == '#string'
    Then match response.tags[1].color == '#string'

#   Assert Key Values

    Then match response.tags[0].channel == 'winnersnet'
    Then match response.tags[0].name == 'Match analysiss'
    Then match response.tags[0].resourceId == '5f3ba778d106e300133e4a3f'
    Then match response.tags[0].type == 'predictionAndAnalysis'
    Then match response.tags[0].color == '#2b1d11'

    Then match response.tags[1].channel == 'winnersnet'
    Then match response.tags[1].name == 'Match predictions'
    Then match response.tags[1].resourceId == '5f3ba778d106e300133e4a40'
    Then match response.tags[1].type == 'predictionAndAnalysis'
    Then match response.tags[1].color == '#541f1f'

#   Edit Match Prediction And Analysis

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editMatchPredictionAnalysis
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.tags[0].channel == '#string'
    Then match response.tags[0].name == '#string'
    Then match response.tags[0].resourceId == '#string'
    Then match response.tags[0].type == '#string'
    Then match response.tags[0].color == '#string'

    Then match response.tags[0].channel == 'winnersnet'
    Then match response.tags[0].name == 'Match predictions'
    Then match response.tags[0].resourceId == '5f3ba778d106e300133e4a40'
    Then match response.tags[0].type == 'predictionAndAnalysis'
    Then match response.tags[0].color == '#541f1f'

##  Delete Match Prediction And Analysis

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request emptyGamesPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Type

    Then match response.tags == '#[0]'

#   Assert Key Value

    Then match response.tags == []

##  Delete created Article

    Given def id = {id: '#(articleId)'}
    Given def deleteArticle = call read('file:src/test/java/helper/delete-news.feature') id