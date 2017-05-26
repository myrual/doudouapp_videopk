# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## api for mobile app and wxapp

### create video
url: host/api/v1/videos.json

method: post

json paramter

{'appid':'app123', 'appsecret':'333', 'user_id':1, 'user_token':auth_token, 'video_title':'api create video', 'video_description':'create video by api, upload video by upyun'}
```
successRes = requests.post(rooturl+ "/api/v1/videos.json", params={'appid':'app123', 'appsecret':'333', 'user_id':user_id, 'user_token':auth_token, 'video_title':'api create video', 'video_description':'create video by api, upload video by upyun'})
print(successRes)
jsonResult = successRes.json()
print(jsonResult)
video_id = jsonResult["id"]
```
raw_input("create videos.json with correct user token should work")

### update video url and post url
url: host/api/v1/videos/1/new_ext_video.json

method: post

json paramter

{'appid':'app123', 'appsecret':'333', 'user_id':user_id, 'user_token':auth_token, 'provider':'upyun', 'videourl':'video xxx url on upyun', 'posturl':'post urlxxx'}
```
successRes = requests.post(rooturl+ "/api/v1/videos/" + str(video_id) + "/new_ext_video.json", params={'appid':'app123', 'appsecret':'333', 'user_id':user_id, 'user_token':auth_token, 'provider':'upyun', 'videourl':'video xxx url on upyun', 'posturl':'post urlxxx'})
print(successRes)
jsonResult = successRes.json()
print(jsonResult)
video_id = jsonResult["id"]
raw_input("create videos.json with correct user token should work")
```
### create battle
url: host/api/v1/battles.json

method: post

json paramter

{'appid':'app123', 'appsecret':'333', 'user_id':123, 'user_token':auth_token, 'battle_title':'upyun', 'battle_description':'video xxx url on upyun', 'battle_left_video_id':'post urlxxx','battle_right_video_id':'post urlxxx'}

```
successRes = requests.post(rooturl+ "/api/v1/battles.json", params={'appid':'app123', 'appsecret':'333', 'user_id':user_id, 'user_token':auth_token, 'battle_title':'api create battle', 'battle_description':'create battle by api', 'battle_left_video_id':1, 'battle_right_video_id':2})
print(successRes)
jsonResult = successRes.json()
print(jsonResult)
raw_input("create battle by post battles.json with correct user token should work")
```
### get single battle
url: host/api/v1/battles/1.json

method: get

json paramter

{'appid':'app123', 'appsecret':'333'}

```
battleID = jsonResult[0]['id']
successRes = requests.get(rooturl+ "/api/v1/battles/" + str(battleID) + ".json", params={'appid':'app123', 'appsecret':'333', 'user_email':userEmail, 'user_token':auth_token})
print(successRes.json())
raw_input("get single battles json with correct user token should work")

```
