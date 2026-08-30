Feature: Add Likes

Background: 

* url apiUrl

Scenario: Add Likes

Given path 'articles',slug,'favorite'
And request {}
When method post
Then status 200

* def favoriteCount = response.article.favoritesCount