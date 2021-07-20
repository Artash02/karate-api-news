Feature: Check publish article functionality

  Background: Generate Current Time Stamp and payload.

    Given def currentTimeStamp = function() { return java.lang.System.currentTimeMillis() + '' }
    Given def payload =
  """
  function(actionName) {
    var dbUtils = Java.type('utils.DbUtils');
    var payload = new dbUtils();
    return payload.getPayload(actionName);
  }
  """

  Scenario: 1. Create Article,2. Add Article Content, 3. Upload Image, 4. Add Channel

##  Create Article

    Given def userInfo = call read('file:src/test/java/helper/get-user-info.feature')
    Given def createArticlePayload = call payload 'create-article'
    Given url api_news_host + '/api/news'
    And header authorization = 'Bearer ' + access_token
    And def articleName = 'article_title_api_test' + currentTimeStamp()
    And set createArticlePayload.title = articleName
    Given request createArticlePayload
    When method post
    Then status 201
    And def articleId = response.newsId

##  Add Article Content

    Given def addContentPayload = call payload 'add-content'
    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addContentPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Upload Image

    Given url api_news_host + '/api/news/' + articleId
    Given def setImagePayload = call payload 'set-image'
    Given request setImagePayload
    Given header authorization = 'Bearer ' + access_token
    When method put
    Then status 200
    * print 'UPLOAD IMAGE' + response

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Add Channel

    Given url api_news_host + '/api/news/' + articleId
    Given def setChannelPayload = call payload 'add-channel'
    Given header authorization = 'Bearer ' + access_token
    Given request setChannelPayload
    When method put
    Then status 200
    * print 'ADD CHANNEL' + response

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Publish Article

    Given url api_news_host + '/api/news/status/' + articleId
    Given def publishArticlePayload = call payload 'publish-article'
    Given header authorization = 'Bearer ' + access_token
    Given request publishArticlePayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.status == '#string'

#   Assert Key value

    Then match response.status == 'published'

##  Check Article Status

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    When method get
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.status == '#string'

#   Assert Key value

    Then match response.status == 'published'

##  Delete Created Article

    Given def id = {id: '#(articleId)'}
    Given def deleteArticle = call read('file:src/test/java/helper/delete-news.feature') id