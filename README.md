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

[{"id":35,"title":"api create battle","description":"create battle by api","user_id":1,"left_video_url":"/uploads/video/video/1/ssss_video.mov","left_video_poster":"","left_votes":0,"right_video_url":"/uploads/video/video/2/jpxnrKmnqZKkoZ2p_-5_2017-04-16.mp4","right_video_poster":"","right_votes":0},{"id":34,"title":"api create battle","description":"create battle by api","user_id":1,"left_video_url":"/uploads/video/video/1/ssss_video.mov","left_video_poster":"","left_votes":0,"right_video_url":"/uploads/video/video/2/jpxnrKmnqZKkoZ2p_-5_2017-04-16.mp4","right_video_poster":"","right_votes":0},{"id":32,"title":"fight back","description":null,"user_id":1,"left_video_url":"/uploads/video/video/40/jpxnrKmnqZKkoZ2p_-5_2017-04-16.mp4","left_video_poster":"","left_votes":1,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":1},{"id":31,"title":"fight back","description":null,"user_id":1,"left_video_url":"/uploads/video/video/39/ssss_video.mov","left_video_poster":"","left_votes":1,"right_video_url":"/uploads/video/video/38/ssss_video.mov","right_video_poster":"","right_votes":1},{"id":30,"title":"fight back","description":null,"user_id":1,"left_video_url":"/uploads/video/video/38/ssss_video.mov","left_video_poster":"","left_votes":0,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":4},{"id":29,"title":"Showcongra","description":null,"user_id":13,"left_video_url":"/uploads/video/video/37/51712169863__ABAA82E8-EAB3-4B76-A59C-028572B45492.MOV","left_video_poster":"","left_votes":1,"right_video_url":"/uploads/video/video/36/51712120654__B0DB1512-A87F-498C-9BD0-CE59E17D7293.MOV","right_video_poster":"","right_votes":2},{"id":28,"title":"fight back","description":null,"user_id":13,"left_video_url":"/uploads/video/video/36/51712120654__B0DB1512-A87F-498C-9BD0-CE59E17D7293.MOV","left_video_poster":"","left_votes":2,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":2},{"id":27,"title":"fight back","description":null,"user_id":13,"left_video_url":"/uploads/video/video/35/51711595155__078F674E-123A-4A33-B999-699A896F176C.MOV","left_video_poster":"","left_votes":4,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":0},{"id":26,"title":"fight back","description":null,"user_id":4,"left_video_url":"http://videopk-heroku-lilin.b0.upaiyun.com/uploads/video/video/35/VID_20170518_132054.mp4","left_video_poster":"http://dd-doudouapp-com.b0.upaiyun.com/uploads/video/video/14/left_video_oneTrue.jpg","left_votes":8,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":7},{"id":25,"title":"fight back","description":null,"user_id":4,"left_video_url":"/uploads/video/video/33/ssss_video.mov","left_video_poster":"","left_votes":4,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":5},{"id":23,"title":"fight back","description":null,"user_id":4,"left_video_url":"/uploads/video/video/31/ssss_video.mov","left_video_poster":"","left_votes":4,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":5},{"id":22,"title":"VS fight back VS fight back","description":null,"user_id":4,"left_video_url":"/uploads/video/video/30/ssss_video.mov","left_video_poster":"","left_votes":2,"right_video_url":"/uploads/video/video/28/ssss_video.mov","right_video_poster":"","right_votes":4},{"id":17,"title":"a vs b","description":null,"user_id":4,"left_video_url":"/uploads/video/video/26/ssss_video.mov","left_video_poster":"","left_votes":30,"right_video_url":"/uploads/video/video/1/ssss_video.mov","right_video_poster":"","right_votes":26},{"id":6,"title":"a vs b","description":"demo","user_id":1,"left_video_url":"/uploads/video/video/1/ssss_video.mov","left_video_poster":"","left_votes":19,"right_video_url":"","right_video_poster":"","right_votes":20}]
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

{u'left_video_id': 1, u
'right_votes': 0, u'user_id': 1, u'description': u'create battle by api', u'left_votes': 0, u'title': u'api create battle', u'left_video_url': u'/uploads/video/video/1/ssss_video.mov', u'left_video_poster': u'', u'right_video_url': u'/uploads/video/video/2/jpxnrKmnqZKkoZ2p_-5_2017-04-16.mp4', u'right_video_id': 2, u'right_video_poster': u'', u'id': 35}

```
