Feature: Get User Info

  Scenario: Get User Info

    Given url api_auth_host + '/users?limit=10000'
    And header authorization = 'Bearer ' + access_token
    When method get
    Then status 200

#   Check Security Response Headers

#    * json jsonHeaders = responseHeaders
#    * def securityHeaders = call read('file:src/test/java/helper/security-headers.feature') { headers: '#(jsonHeaders)' }

    And def authorId = karate.jsonPath(response, "$.adminList[?(@.firstName=='Zeus')].id")
    And def authorLastName = karate.jsonPath(response, "$.adminList[?(@.firstName=='Zeus')].lastName")
    And def authorEmail = karate.jsonPath(response, "$.adminList[?(@.firstName=='Zeus')].email")

    * print authorId
    * print authorLastName
    * print authorEmail


