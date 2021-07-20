Feature: Check Settings Functionality

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

    Given def addChannelPayload = call payload 'add-channel'
    Given def editChannelPayload = call payload 'edit-channel'
    Given def editAuthorPayload = call payload 'edit-user'
    Given def emptyUserAndEmptyChannelPayload = call payload "empty-user-and-empty-channel"
    Given def emptyUserPayload = call payload "empty-user"


  Scenario: 1. Create Article, 2. Add Settings, 3. Edit Channels,
  4. Edit Author, 5. Add Empty Channel and Empty Author 6. Delete created Article

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

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

##  Add Settings

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request addChannelPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }


#  Assert Key Types

    Then match response.products == '#array'

#  Assert Key Types

    Then match response.products == [6]

##  Edit Channels

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editChannelPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#  Assert Key Types

    Then match response.products == '#array'

#  Assert Key Values

    Then match response.products == [1,4]

##  Edit Author

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request editAuthorPayload
    When method put
    Then status 200

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#  Assert Key Types

    Then match response.author.email == '#string'
    Then match response.author.firstName == '#string'
    Then match response.author.id == '#string'
    Then match response.author.lastName == '#string'

#  Assert Key Values

    Then match response.author.email == 'chief-editor@winesports.com'
    Then match response.author.firstName == 'Chiefdd'
    Then match response.author.id == '5e9192dae966af0010b65b63'
    Then match response.author.lastName == 'Editor'

##  Add Empty Channel and Empty Author

    Given url api_news_host + '/api/news/' + articleId
    Given header authorization = 'Bearer ' + access_token
    Given request emptyUserAndEmptyChannelPayload
    When method put
    Then status 409

#   Check Security Response Headers

#    * print 'HEADERSSSSSSSSSSSSSSSSSS'
#    * print 'headers:', karate.prevRequest.headers
#    * json jsonHeaders = responseHeaders
#    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

#   Assert Key Types

    Then match response.errors == '#[4]'
    Then match response.message == '#string'

#   Assert Key Values

    Then match response.errors[0].message == '\"id\" is not allowed to be empty'
    Then match response.errors[0].slug == 'invalid-id-any-empty'
    Then match response.errors[0].details.path == 'author.id'

    Then match response.errors[1].message == '\"firstName\" is not allowed to be empty'
    Then match response.errors[1].slug == 'invalid-firstName-any-empty'
    Then match response.errors[1].details.path == 'author.firstName'

    Then match response.errors[2].message == '\"lastName\" is not allowed to be empty'
    Then match response.errors[2].slug == 'invalid-lastName-any-empty'
    Then match response.errors[2].details.path == 'author.lastName'

    Then match response.errors[3].message == '\"email\" is not allowed to be empty'
    Then match response.errors[3].slug == 'invalid-email-any-empty'
    Then match response.errors[3].details.path == 'author.email'

    Then match response.message == 'child \"author\" fails because [child \"id\" fails because [\"id\" is not allowed to be empty], child \"firstName\" fails because [\"firstName\" is not allowed to be empty], child \"lastName\" fails because [\"lastName\" is not allowed to be empty], child \"email\" fails because [\"email\" is not allowed to be empty]]'

##  Delete created Article

    Given def id = {id: '#(articleId)'}
    Given def deleteArticle = call read('file:src/test/java/helper/delete-news.feature') id
