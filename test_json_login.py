import requests
rooturl = "https://dd.doudouapp.com/"
failedRes = requests.get(rooturl+"/api/v1/battles.json")
print(failedRes.text)
userEmail = "1307728951@qq.com"
userPass = "123456"
loginWithoutAppidRes = requests.post(rooturl+ "/users/sign_in.json", params={'appsecret':'333', 'email':userEmail, 'password':userPass})
print(loginWithoutAppidRes.text)
raw_input()

loginRes = requests.post(rooturl+ "/users/sign_in.json", params={'appid':'app123', 'appsecret':'333', 'email':userEmail, 'password':userPass})
print(loginRes.text)

jsonResult = loginRes.json()
auth_token = jsonResult['authentication_token']

successRes = requests.get(rooturl+ "/api/v1/battles.json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
jsonResult = successRes.json()
battleID = jsonResult['id']

print(successRes)
print(successRes.text)
raw_input()
successRes = requests.post(rooturl+ "/api/v1/battles/" + str(battleID) + "/follow_right_video.json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
print(successRes)
print(successRes.text)

failedRes = requests.get(rooturl+"/api/v1/battles.json")
print(failedRes.text)
