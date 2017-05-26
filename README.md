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

