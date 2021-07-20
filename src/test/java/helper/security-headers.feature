Feature: Check Security Response Headers

  Scenario: Check Security Response Headers

    * json responseHeaders = { headers: '#(jsonHeaders)' }
    * match responseHeaders.headers.X-Response-Time == '#array'
    * match responseHeaders.headers.Strict-Transport-Security == ["max-age=63072000; includeSubdomains; preload"]
    * match responseHeaders.headers.X-Frame-Options == ["SAMEORIGIN"]
    * match responseHeaders.headers.X-Content-Type-Options == ["nosniff"]
    * match responseHeaders.headers.X-Xss-Protection == ["1; mode=block"]
