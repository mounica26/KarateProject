@signup
Feature: Signup

Background: Precondition

* def dataGenerator = Java.type('helpers.DataGenerator')

Scenario: sign up


* def email = dataGenerator.randomEmail()
* def name = dataGenerator.randomname()
Given url 'https://conduit-api.bondaracademy.com/api/users'

And request 
"""
{"user":{"email":"#(email)",
 "password":"<password>",
  "username":"#(name)"}}
"""
When method post
Then status 201

@ignore
Scenario Outline: Verify different signup validations

Given url 'https://conduit-api.bondaracademy.com/api/users'
And request 
"""
{"user":{"email":"<email>",
 "password":"<password>",
  "username":"<username>"}}
"""
When method post
Then status 422
And match response == <error message>

Examples:
| email     | password | username | error message                                                                          |
| hv        | hb       | tftf     | {errors: {email: ["is invalid"], password: ["is too short (minimum is 8 characters)"]}}|
| hv@t.com  | hb       | tftf     | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                     |
