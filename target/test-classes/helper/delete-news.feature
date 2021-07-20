Feature: Delete Article

  Scenario: Delete

    * def Id = __arg.id
    * print 'IDDDDDDDDDDD' + Id
    Given url api_news_host + '/api/news/' + Id
    Given header authorization = 'Bearer ' + access_token
    When method delete
    Then status 204

#   Check Security Response Headers

    * json jsonHeaders = responseHeaders
    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

