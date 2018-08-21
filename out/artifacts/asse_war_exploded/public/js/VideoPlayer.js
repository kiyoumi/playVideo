Player = {
   ois: '120.55.161.125:5000',
   divId: 'player',
   playAuthStatus: -1, //0是开始鉴权
   watchDuration: 290, //试看时间
   meta: 0, //媒资类型
   urls: null, //媒资url
   currentSerial: 0, //当前集数
   id: 0, //媒资id
   status: 0, //当前状态  【视频聚合内容时才用到】
   realUrl: '', //真实播放地址
   checkTimeout: -1,
   user: 'sunniwell',
   loaded: false,
   checkPlayUrl: function(__url, __mediaId, __meta, __isFinal) {
      console.log(url);
      this.meta = __meta;
      if (__url.indexOf("mop://") != -1) {
         this.mopUrl2RealUrl(__url, __mediaId, __meta);
      } else {
         if (__isFinal) {
            this.realUrl = __url;
            //console.log(__url);
            this.playVideo(__url);
         } else {
            //DialogUtil.showLoading("");
            //this.status = 1;
            //this.playVideo(__url, __meta);
            //EPGSUtil.getRealUrl(__url, "realUrl");
            //clearTimeout(this.checkTimeout);
            //this.checkTimeout = setTimeout("checkRealUrlFail()", 10000);
         }
      }
   },
   mopUrl2RealUrl: function(__url, __mediaId, __meta) {
      console.log(__url);
      var play_url = null;
      var suffix = ".m3u8"; //默m3u8
      var protocal = "hls"; //默认为hls
      var firstWord = __mediaId.substring(0, 1);
      if (firstWord == "F") {
         suffix = ".m3u8";
         protocal = "hls";
      } else if (firstWord == "M") {
         suffix = ".ts";
         protocal = "http";
      }
      if (__meta == 5 || __meta == 6) { //ABR
         play_url = "http://" + this.ois + "/" + __mediaId + suffix + "?protocal=" + protocal + "&user=" + this.user + "&tid=pccommon&sid=" + __mediaId + "&type=pc&token=" + "guoziyun";
      } else {
         play_url = "http://" + this.ois + "/" + __url.substring(6) + suffix + "?protocal=" + protocal + "&user=" + this.user + "&tid=pccommon&sid=" + __mediaId + "&type=pc&token=" + "guoziyun"; //hls or http
      }
      console.log(play_url);
      this.playVideo(play_url);

   },
   playVideo: function(play_url) {
      var flashvars = {
         f: 'ckplayer/m3u8.swf',
         a: encodeURIComponent(play_url),
         c: '0',
         p: '1',
         s: '4',
         lv: '0',
         k: '',
         n: '',
         loaded: 'loadedHandler' //当播放器加载完成后发送该js函数loaded
      };
      if (play_url.indexOf("m3u8") == -1) {
         flashvars.f = encodeURIComponent(play_url);
         flashvars.a = '';
         flashvars.s = '0';
      }
      var device = this.getDeviceType();
      switch (device) {
         case "pc":
            break;
         case "ipad":
         case "iphone":
         case "android mobile":
         case "andorid pad":
            flashvars.f = encodeURIComponent(play_url);
            flashvars.a = '';
            flashvars.s = '0';
            flashvars.e = '0';
            flashvars.p = '1';
            break;
      }
      var video = [encodeURIComponent(play_url)];
      var params = {
         bgcolor: '#FFF',
         allowFullScreen: true,
         allowScriptAccess: 'always',
         wmode: "transparent"
      };
      var support = ['iPad', 'iPhone', 'ios', 'android+false', 'msie10+false']; //默认的在ipad,iphone,ios设备中用html5播放,android,ie10上没有安装flash的也调用html5
      if (device == "iphone" || device == "ipad" || device == "android mobile" || device == "android pad") {
         video = [play_url];
         if (!this.checkVideo()) {
            CKobject.embed("ckplayer/ckplayer.swf", this.divId, 'ckplayer_a1', '100%', '100%', false, flashvars, video, params);
         } else {
            CKobject.embedHTML5(this.divId, 'player_a1', '100%', '100%', video, flashvars, support);
         }
      } else {
         CKobject.embed("ckplayer/ckplayer.swf", this.divId, 'ckplayer_a1', '100%', '100%', false, flashvars, video, params);
      }
   },
   checkVideo: function() {
      if (!!document.createElement('video').canPlayType) {
         var vidTest = document.createElement("video");
         oggTest = vidTest.canPlayType('video/ogg; codecs="theora, vorbis"');
         if (!oggTest) {
            h264Test = vidTest.canPlayType('video/mp4; codecs="avc1.42E01E, mp4a.40.2"');
            if (!h264Test) {
               return false;
            } else {
               if (h264Test == "probably") {
                  return true;
               } else {
                  return false;
               }
            }
         } else {
            if (oggTest == "probably") {
               return true;
            } else {
               return false;
            }
         }
      } else {
         return false;
      }
   },
   getDeviceType: function() {
      var deviceType = "";
      if (!deviceType) {
         var userAgent = navigator.userAgent.toLowerCase();
         var regex_ua_ipad = /ipad/i;
         var regex_ua_iphone = /iphone os/i;
         var regex_ua_android = /android/i;

         if (userAgent.match(regex_ua_ipad)) {
            deviceType = "ipad";
         } else if (userAgent.match(regex_ua_iphone)) {
            deviceType = "iphone";
         } else if (userAgent.match(regex_ua_android)) {
            var orientation = window.orientation;
            var deviceWidth = window.document.body.offsetWidth;
            deviceType = "android mobile";
            if (orientation == 0 || orientation == 180) { //横屏
               if (deviceWidth > 1000) {
                  deviceType = "android pad";
               }
            } else { //竖屏
               if (deviceWidth > 700) {
                  deviceType = "android pad";
               }
            }
         } else {
            deviceType = "pc";
         }
      }
      return deviceType;
   },
   getRealUrl: function (__url, __mediaId, __meta){
      var play_url = null;
      var suffix = ".m3u8"; //默m3u8
      var protocal = "hls"; //默认为hls
      var firstWord = __mediaId.substring(0,1);
      if (firstWord == "F") {
         suffix = ".m3u8";
         protocal = "hls";
      } else if (firstWord == "M") {
         suffix = ".ts";
         protocal = "http";
      }
      if (__meta == 5 || __meta == 6) { //ABR
         play_url = "http://" + this.ois + "/" + __mediaId + suffix + "?protocal=" + protocal + "&user=" + this.user + "&tid=pccommon&sid=" + __mediaId + "&type=pc&token=" + "guoziyun";
      } else {
         play_url = "http://" + this.ois + "/" + __url.substring(6) + suffix + "?protocal=" + protocal + "&user=" + this.user + "&tid=pccommon&sid=" + __mediaId + "&type=pc&token=" + "guoziyun"; //hls or http
      }
      return play_url;
   },
   setOIS:function(str){
      this.ois=str;
   }
}