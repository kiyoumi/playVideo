/**
 * Created by ThinkPad on 2016/1/28.
 */
/*show play details*/
var array=[];
function showPlayInfor(a,b,c,d){
    for(var i=0;i<arguments.length;i++){
        array.push(arguments[i]);
    }
    array.forEach(function(v){
        $("."+v).bind("click",function(){
            $("#"+v+"_content").css("display","block").siblings().css("display","none");
            if( v =="returnPlay"){
                $("#content_box").css("background-color","#F5F5F5");
            }
            else{
                $("#content_box").css("background-color","#FFFFFF");
            }
        });
    });
}



/*play video*/
function loadedHandler() {
    CKobject.getObjectById('ckplayer_a1').videoSeek(getTime()-8);
}
function getTime(){
    var id = $("#media").attr("mediaId");
    var playRecord = JSON.parse(localStorage.getItem("playRecord-mini"));
    var userName=localStorage.getItem("userName");
    if(playRecord == null){
        return null;
    }else{
        var user;
        var thisInfor;
        var ifSamePerson;
        var _re;
        for(var i=0;i< playRecord.length;i++){
            for(var k in playRecord[i]){
                user=k;
            }
            if(user==userName){
                ifSamePerson=true;
                _re=i;
            }
        }
        if(ifSamePerson){
            thisInfor=playRecord[_re][userName];
            for(var j=0;j<thisInfor.length;j++){
                if(id == thisInfor[j].id){
                    return thisInfor[j].time;
                }
                else{
                    return 0;
                }
            }
        }
    }
}
var timeNow;
var NUM;
var s = $(window).height();
var PlayUtil = {
    playAuthStatus: -1, //0是开始鉴权
    watchDuration: 290, //试看时间
    meta: 0, //媒资类型
    urls: null, //媒资url
    currentSerial: 0, //当前集数
    id: 0, //媒资id
    status: 0, //当前状态  【视频聚合内容时才用到】
    realUrl: '', //真实播放地址
    checkTimeout: -1,
    loaded: false,
    user: '',
    tid: '',
    checkPlayUrl: function(__url, __mediaId, __meta, __isFinal,num,uin,tin,token,random,timeStamp,sign,playS) {
        this.mopUrl2RealUrl(__url, __mediaId, __meta,num,uin,tin,token,random,timeStamp,sign,playS);
    },
    mopUrl2RealUrl: function(__url, __mediaId, __meta,num,uin,tin,token,random,timeStamp,sign,playS) {
        var title=document.title;
        var newUrl=__url.replace("m3u8","ts");
        $(".downloadMeta a").attr({"href":newUrl,"download":title});
        var ois = this.ois;
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
            //play_url = "http://" + ois + "/" + __mediaId + suffix + "?protocal=" + protocal + "&user=" + this.user + "&tid="+ this.tid +"&sid=" + __mediaId + "&type=pc&token=" + "guoziyun";
            play_url = __url + "&uin=" + uin + "&tin="+tin+"&token=" +token+"&sid=" + __mediaId + "&sign="+sign+"&random="+random+"&timeStamp="+timeStamp+"";
        } else {
            //play_url = "http://" + ois + "/" + __url.substring(6) + suffix + "?protocal=" + protocal + "&user=" + this.user + "&tid="+ this.tid +"&sid=" + __mediaId + "&type=pc&token=" + "guoziyun"; //hls or http
            play_url = __url+ "&uin=" + uin + "&tin="+tin+"&token=" +token+"&sid=" + __mediaId + "&sign="+sign+"&random="+random+"&timeStamp="+timeStamp+"";
        }
        this.playVideo(play_url,num,playS);
    },
    playVideo: function (__url,num,playS){
        NUM=num;
        var flashvars={
            f : 'public/js/ckplayer/m3u8.swf',  //使用swf向播放器发送视频地址进行播放
            a: __url,	//m3u8文件
            my_url:__url,
            e:6,
            c: 0,		//调用 ckplayer.js 配置播放器
            p: playS,		//1自动播放视频 0暂停
            s: 4,		//flash插件形式发送视频流地址给播放器进行播放
            lv: 0,		//注意，如果是直播，需设置lv:1
            loaded: 'loadedHandler'   //当播放器加载完成后发送该js函数loaded
        };
        if(__url.indexOf("m3u8")==-1){
            flashvars.f=encodeURIComponent(__url);
            flashvars.a='';
            flashvars.s='0';
        }
        var device = this.getDeviceType();
        switch(device){
            case "pc":
                break;
            case "ipad":
            case "iphone":
            case "android mobile":
            case "andorid pad":
                flashvars.f=encodeURIComponent(__url);
                flashvars.a='';
                flashvars.s='0';
                flashvars.e = '1';
                flashvars.p = '1';
                break;
        }
        var video=[__url];
        var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always',wmode:"transparent"};
        var support=['iPad','iPhone','ios','android+false','msie10+false'];//默认的在ipad,iphone,ios设备中用html5播放,android,ie10上没有安装flash的也调用html5
        if(device=="iphone"||device=="ipad"||device=="android mobile"||device=="android pad"){
            video = [encodeURIComponent(__url)];
            if(!this.checkVideo()){
                CKobject.embed("public/js/ckplayer/ckplayer.swf",'a1','ckplayer_a1','100%',192,false,flashvars,video,params);
            } else {
                CKobject.embedHTML5('a1','ckplayer_a1','100%',192,video,flashvars,support);
                window.setInterval(function(){
                    timeNow=Math.floor(CKobject.getObjectById('ckplayer_a1').getStatus().time);
                    if(isNaN(timeNow)){
                        timeNow=0;
                    }
                    localStorage.setItem("Time-mini",timeNow);
                    savePlayRecord(NUM);
                },3000);
            }
        }else{
            $("#a1").attr("url",video);
            CKobject.embed('public/js/ckplayer/ckplayer.swf','a1','ckplayer_a1','100%','100%',false, flashvars ,video, params);
        }
    },
    checkVideo:function(){
        if (!!document.createElement('video').canPlayType) {
            var vidTest = document.createElement("video");
            var oggTest = vidTest.canPlayType('video/ogg; codecs="theora, vorbis"');
            if (!oggTest) {
                var h264Test = vidTest.canPlayType('video/mp4; codecs="avc1.42E01E, mp4a.40.2"');
                if (!h264Test) {return false;
                }else {
                    if (h264Test == "probably") {
                        return true;
                    }else {
                        return false;
                    }
                }
            }else {
                if (oggTest == "probably") {
                    return true;
                }else {
                    return false;
                }
            }
        }else {
            return false;
        }
    },
    getDeviceType:function(){
        var deviceType= "";
        if(!deviceType){
            var userAgent  =  navigator.userAgent.toLowerCase();
            var regex_ua_ipad= /ipad/i;
            var regex_ua_iphone= /iphone os/i;
            var regex_ua_android= /android/i;

            if(userAgent.match(regex_ua_ipad)){
                deviceType= "ipad";
            }else if(userAgent.match(regex_ua_iphone)){
                deviceType= "iphone";
            }else if(userAgent.match(regex_ua_android)){
                var orientation= window.orientation;
                var deviceWidth= window.document.body.offsetWidth;
                deviceType= "android mobile";
                if(orientation== 0 || orientation== 180){  //横屏
                    if(deviceWidth> 1000){
                        deviceType= "android pad";
                    }
                }else{ //竖屏
                    if(deviceWidth> 700){
                        deviceType= "android pad";
                    }
                }
            }else{
                deviceType= "pc";
            }
        }
        return deviceType;
    },
    setOIS:function(str){
        this.ois=str;
    }
};

function playerstop(){
    play(num,0);
}
//playS:1自动播放视频 0暂停
function play(num,playS){
    if(playS==0){
    }else{
        playS=1;
    }
    var uin=localStorage.getItem("uin");
    var tin=localStorage.getItem("tin");
    var token=localStorage.getItem("token");
    var ps = $('p[name=url]');
    var urls = [];
    ps.each(function (index, element){
        urls.push({
            url: $(this).html(),
            isfinal: $(this).attr('final')
        });
    });
    var mediaId = $('#media').attr('mediaId');
    var meta = $('#media').attr('meta');
    if (urls.length > 0) {
        num = (num == null || num == '') ? 0 : num;
        num = (num > urls.length) ? (urls.length - 1) : num;
        var random=Random();
        var timeStamp=new Date().getTime();
        var sign=SHA256($.cookie("signUin")+random+timeStamp);
        var isfinal = urls[num].isfinal;
        var url = urls[num].url;
        PlayUtil.checkPlayUrl(url, mediaId, meta, isfinal,num,uin,tin,token,random,timeStamp,sign,playS);
    }

}


/*save play record*/
Array.prototype.indexOf = function(val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == val) return i;
    }
    return -1;
};
Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};
function savePlayRecord(num){
    var flag;
    var _re;
    var _rePlay;
    var play_id=$("#menu").attr("play_id");
    var play_columnid=$("#menu").attr("play_columnid");
    var play_img=$("#menu").attr("play_img");
    var play_title=document.title;
    var meta=$("#media").attr("meta");
    var time=localStorage.getItem("Time-mini");
    var userName=localStorage.getItem("userName");
    var user;
    var user_index;
    var ifSamePerson;
    var _play={
        columnid:play_columnid,
        id:play_id,
        title:play_title,
        img:play_img,
        time:time,
        num:num,
        meta:meta};
    var onePlay={};
    onePlay[userName]=_play;
    onePlay[userName].num=num;
    localStorage.setItem("onePlay",JSON.stringify(onePlay));
    var onePlay = JSON.parse(localStorage.getItem("onePlay"));
    if (localStorage.getItem("playRecord-mini")==null) {
        var array=[{}];
        array[0][userName]=[_play];
        localStorage.setItem("playRecord-mini",JSON.stringify(array));
    }
    else{
        var playRecord=JSON.parse(localStorage.getItem("playRecord-mini"));//字符串形式转换数组
        for (var i = 0; i < playRecord.length; i++) {
            for(var k in playRecord[i]){
                user=k;
            }
            if(user==userName){
                ifSamePerson=true;
                for(var m=0;m<playRecord[i][userName].length;m++){
                    if(playRecord[i][userName][m].id == onePlay[userName].id){
                        flag=true;
                        _re=m;
                    }
                }
                _rePlay=playRecord[i][userName][_re];
                user_index=i;
            }
        }
        if(ifSamePerson){
            if (flag) {
                playRecord[user_index][userName].remove(_rePlay);
                playRecord[user_index][userName].unshift(onePlay[userName]);
                localStorage.setItem("playRecord-mini",JSON.stringify(playRecord));
            }else{
                playRecord[user_index][userName].unshift(onePlay[userName]);
            }
        }
        else{
            var array2={};
            array2[userName]=[_play];
            playRecord.push(array2);
        }
        localStorage.setItem("playRecord-mini",JSON.stringify(playRecord));
    }
}

function Random() {
    var old = (Math.round(Math.random() * 90000) + 10000).toString();
    var random = old.replace(/0/g, "2");
    return random;
}

/* user collect*/
function collectInfo(){
    var flag2,flag1=false,flag3=false;
    var _rePlay;
    var play_id=$("#menu").attr("play_id");
    var play_columnid=$("#menu").attr("play_columnid");
    var play_img=$("#menu").attr("play_img");
    var play_title=$("#menu").attr("title");
    var userName=localStorage.getItem("userName");
    var user1,user2,user3;
    var user_index1,_index, user_index2,_index2;
    var ifSamePerson,ifSamePerson1;
    var meta=$("#media").attr("meta");
    var _play={
        likeSign:"0",
        columnid:play_columnid,
        id:play_id,
        title:play_title,
        img:play_img,
    };
    var oneCollect={};
    oneCollect[userName]=_play;
    localStorage.setItem("oneCollect",JSON.stringify(oneCollect));

    var collectRecord;
    collectRecord=JSON.parse(localStorage.getItem("collectRecord"));
    if(collectRecord!==null){
        for (var i = 0; i < collectRecord.length; i++) {
            for(var k in collectRecord[i]){
                user3=k;
            }
            if(user3==userName){
                for(var m=0;m<collectRecord[i][userName].length;m++){
                    if(collectRecord[i][userName][m].id == oneCollect[userName].id){
                        flag3=true;
                    }
                }
            }
        }
        if(flag3){
            _play.likeSign=1;
            oneCollect[userName]=_play;
            localStorage.setItem("oneCollect",JSON.stringify(oneCollect));
        }
    }

    if(oneCollect[userName].likeSign==1){
        $(".userLike").addClass("likeStyle");
    }

    $(".userLike").bind("click",function(){
        if($(".likeSign").hasClass("displayNone")){
            if (localStorage.getItem("collectRecord")==null) {
                var array=[{}];
                array[0][userName]=[_play];
                localStorage.setItem("collectRecord",JSON.stringify(array));
            }
            /*collect*/
            if(oneCollect[userName].likeSign==0){
                $(".userLike").addClass("likeStyle");
                oneCollect[userName].likeSign=1;
                localStorage.setItem("oneCollect",JSON.stringify(oneCollect));
                oneCollect = JSON.parse(localStorage.getItem("oneCollect"));
                collectRecord=JSON.parse(localStorage.getItem("collectRecord"));
                for (var i = 0; i < collectRecord.length; i++) {
                    for(var k in collectRecord[i]){
                        user1=k;
                    }
                    if(user1==userName){
                        ifSamePerson1=true;
                        for(var m=0;m<collectRecord[i][userName].length;m++){
                            if(collectRecord[i][userName][m].id == oneCollect[userName].id){
                                flag1=true;
                                _index=m;
                            }
                        }
                        user_index1=i;
                    }
                }
                if(ifSamePerson1){
                    if(flag1==false){
                        collectRecord[user_index1][userName].unshift(oneCollect[userName]);
                    }
                    else{
                        if(collectRecord[user_index1][userName].length>0){
                            collectRecord[user_index1][userName][_index].likeSign=1;
                        }
                    }
                }
                else{
                    var array2={};
                    array2[userName]=[oneCollect[userName]];
                    collectRecord.push(array2);
                }
                localStorage.setItem("collectRecord",JSON.stringify(collectRecord));
                $(".likeSign").html("成功添加至-我的收藏").removeClass("displayNone").removeClass("_likeSign");
                window.setTimeout(function (){
                    $(".likeSign").addClass("displayNone");
                }, 1000);
            }
            /*cancel collect*/
            else{
                $(".userLike").removeClass("likeStyle");
                oneCollect[userName].likeSign=0;
                var collectRecord=JSON.parse(localStorage.getItem("collectRecord"));
                for (var i = 0; i < collectRecord.length; i++) {
                    for(var k in collectRecord[i]){
                        user2=k;
                    }
                    if(user2==userName){
                        ifSamePerson=true;
                        for(var m=0;m<collectRecord[i][userName].length;m++){
                            if(collectRecord[i][userName][m].id == oneCollect[userName].id){
                                flag2=true;
                                _index2=m;
                            }
                        }
                        _rePlay=collectRecord[i][userName][_index2];
                        user_index2=i;
                    }
                }
                if(ifSamePerson){
                    if (flag2) {
                        collectRecord[user_index2][userName].remove(_rePlay);
                    }
                }
                localStorage.setItem("collectRecord",JSON.stringify(collectRecord));
                $(".likeSign").html("已取消收藏").removeClass("displayNone").addClass("_likeSign");
                window.setTimeout(function (){
                    $(".likeSign").addClass("displayNone").removeClass("_likeSign");
                }, 1000);
            }
        }
    })
}

/*format time观看时长*/
function formatTime(seconds) {
    if((seconds>60)||(seconds==60)){
        var min = Math.floor(seconds / 60),
            second = seconds % 60,
            hour, newMin, time;
        if ((min > 60)||(min==60)) {
            hour = Math.floor(min / 60);
            if((0<hour)&&(hour<10)){
                hour='0'+hour;
            }
            newMin = min % 60;
            if((0<newMin)&&(newMin<10)){
                newMin='0'+newMin;
            }
        }
        if((10<min)&&(min<60)){
            hour = '00';
            newMin = min;
        }
        if ((0< min)&&(min<10)) {
            hour = '00';
            newMin = '0' + min;
        }
        if(min==0){
            hour='00';
            newMin='00';
        }
        if (second < 10) {
            second = '0' + second;
        }
        time = hour? (hour + ':' + newMin + ':' + second) : (min + ':' + second);
        return ("观看至： "+time);
    }
    if(seconds<60){
        return "观看不足1分钟";
    }
}

