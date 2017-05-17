import requests
localURL = "https://lin-rails-tt-myrual.c9users.io/"
herokuURL = "https://dry-fjord-76939.herokuapp.com/"
officalURL = "https://dd.doudouapp.com"
rooturl = localURL
failedRes = requests.get(rooturl+"/api/v1/battles.json")
print(failedRes.text)
raw_input("get battles.json should failed")
userEmail = "d@d.com"
userPass = "123456"
successRes = requests.get(rooturl+ "/api/v1/battles.json", params={'appid':'app123', 'appsecret':'333'})
print(successRes.json())
raw_input("get battles.json should work after we put appid and appsecret")

loginWithoutAppidRes = requests.post(rooturl+ "/users/sign_in.json", params={'appsecret':'333', 'email':userEmail, 'password':userPass})
print(loginWithoutAppidRes.text)
raw_input("login without app id should failed")

loginRes = requests.post(rooturl+ "/users/sign_in.json", params={'appid':'app123', 'appsecret':'333', 'email':userEmail, 'password':userPass})
print(loginRes.text)

jsonResult = loginRes.json()
auth_token = jsonResult['authentication_token']

successRes = requests.get(rooturl+ "/api/v1/battles.json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
jsonResult = successRes.json()
print(successRes)
print(successRes.text)
raw_input("get battles json with correct user token should work")

battleID = jsonResult[0]['id']
successRes = requests.get(rooturl+ "/api/v1/battles/" + str(battleID) + ".json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
print(successRes.json())
raw_input("get single battles json with correct user token should work")


successRes = requests.get(rooturl+ "/api/v1/streams.json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
jsonResult = successRes.json()
print(jsonResult)
raw_input("get streams/index.json with correct user token should work")

streamID = jsonResult[0]['id']

successRes = requests.get(rooturl+ "/api/v1/streams/" + str(streamID) + ".json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
jsonResult = successRes.json()
print(jsonResult)
raw_input("get streams/" + str(streamID) +".json with correct user token should work")





print(successRes)
print(successRes.text)
raw_input("get battles json with correct user token should work")
successRes = requests.post(rooturl+ "/api/v1/battles/" + str(battleID) + "/follow_right_video.json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
print(successRes)
print(successRes.text)

failedRes = requests.get(rooturl+"/api/v1/battles.json")
print(failedRes.text)
