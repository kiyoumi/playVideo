/**
 * Created by ThinkPad on 2016/1/28.
 */
window.onload=function(){
    IsChrome();
}
var getColumnIds=[];
function CH() {
    $("#search").attr("placeholder","搜索");
    $("#userLogin").html("登录");
    $(".reg").html("注册");
    $(".history").html("记录");
    $(".head .collect").html("收藏");
    $(".zh").html("中文");
    $(".en").html("English");
}
function EN() {
    $("#search").attr("placeholder","search");
    $("#userLogin").html("Login");
    $(".reg").html("Register");
    $(".history").html("History");
    $(".head .collect").html("Collection");
    $(".zh").html("中文");
    $(".en").html("English");
}

if(getCookie("signUin")=="" ||getCookie("signUin")==null || getCookie("signUin")==undefined){
    localStorage.removeItem("uin");
    localStorage.removeItem("tin");
    localStorage.removeItem("token");

}

if(sessionStorage.getItem("accesssvr")=="" || sessionStorage.getItem("accesssvr")==null){
    $.get('media/svr',function (data) {
        if(data.code==0) {
            if(data.result.length>0){
                sessionStorage.setItem("accesssvr",data.result[0].host+':'+data.result[0].http_port);
            }
        }
    })
}

//获取用户信息
function getInfo() {
    if(localStorage.getItem("uin") && getCookie("signUin")){
        setCookie();
        $.get('media/info?uin='+localStorage.getItem("uin")+'&signUin='+getCookie("signUin")+'',function (data) {
            if(data.code==0){
                $(".my_center.f .f.ml-40").addClass("displayNone");
                $(".my_center.f .hasLogin").removeClass("displayNone");
                if(localStorage.getItem("lang")=="zh"){
                    $(".hasLogin").html("<span href='myCenter' class='Hui-iconfont Hui-iconfont-user2' style='font-size: 25px;color:#cB242B;'></span><a href='myCenter' class='nickname'>"+data.result.nickname+"</a><a class='login_' id='userLogout' style='cursor:pointer' onclick='logout()'>注销</a>");
                }else{
                    $(".hasLogin").html("<span href='myCenter' class='Hui-iconfont Hui-iconfont-user2' style='font-size: 25px;color:#cB242B;'></span><a href='myCenter' class='nickname'>"+data.result.nickname+"</a><a class='login_' id='userLogout' style='cursor:pointer' onclick='logout()'>Logout</a>");
                }
                $('.user-name.mt-10 span').html(data.result.nickname);
                $(".info-box .nickname").html(data.result.nickname);
                $("#nick").val(data.result.nickname);
                if(data.result.sex==0){
                    if(localStorage.getItem("lang")=="zh"){
                        $(".info-box .sex").html("保密");
                    }else{
                        $(".info-box .sex").html("Secret");
                    }
                }else if(data.result.sex==1){
                    if(localStorage.getItem("lang")=="zh"){
                        $(".info-box .sex").html("男");
                    }else{
                        $(".info-box .sex").html("male");
                    }
                }else{
                    if(localStorage.getItem("lang")=="zh"){
                        $(".info-box .sex").html("女");
                    }else{
                         $(".info-box .sex").html("female");
                    }
                }
                for(var i=0;i<$(".control-input.sex input").length;i++){
                    if($(".control-input.sex input").eq(i).val()==data.result.sex){
                        $(".control-input.sex input").eq(i).attr("checked","checked").siblings().attr("checked",false);
                        return;
                    }
                }
            }
        })
        /*注销*/
    }else if(window.document.getElementById("play")){
        setTimeout(function () {
            window.location.href="login";
        },2000);
    }

    $(".js-edit-info").unbind("click").bind("click",function () {
        if(getCookie("signUin")){
            $(".edit-info").removeClass("displayNone");
            $(".edit-info #profile-submit").bind("click",function () {
                var nickname=$("#nick").val();
                var sex=$(".sex input[type='radio']:checked").val();
                if(nickname == ''){
                    if(lan=="zh"){
                        $(".tips").html("昵称不能为空!");
                    }else{
                        $(".tips").html("Nickname is not empty");
                    }
                    $(".tips").show();
                    setTimeout(function () {
                        $(".tips").hide();
                    },2000);
                }else if(nickname!= nickname.replace(/[^a-zA-Z0-9-_]/g, '')){
                    if(lan=="zh"){
                        $(".tips").html("昵称只能由字母数字和下划线组成!");
                    }else{
                        $(".tips").html("Nickname can only be made up of letters,numbers,and underscores");
                    }
                    $(".tips").show();
                    setTimeout(function () {
                        $(".tips").hide();
                    },2000);
                }else if(nickname.length<6){
                    if(lan=="zh"){
                        $(".tips").html("昵称用户名长度不能小于6!");
                    }else{
                        $(".tips").html("Nickname is no less than 6 characters");
                    }
                    $(".tips").show();
                    setTimeout(function () {
                        $(".tips").hide();
                    },2000);
                }else if(nickname.length>16) {
                    if(lan=="zh"){
                        $(".tips").html("昵称用户名长度不能大于16!");
                    }else{
                        $(".tips").html("Nickname is no more than 16 characters");
                    }
                    $(".tips").show();
                    setTimeout(function () {
                        $(".tips").hide();
                    },2000);
                }else{
                    modify(localStorage.getItem("uin"),getCookie("signUin"),nickname,sex,"","","","");
                }
            })
            $(".edit-info .close").bind("click",function () {
                $(".edit-info").addClass("displayNone");
            })
        }else{
            if(lan=="zh"){
                alert("登录进行修改!");
            }else{
                alert("Login to modify");
            }
        }
    })
}

//获取年级列表
function getColumns() {
    var columnIds = epgColumn.init(ServerConfig.epgs,ServerConfig.epg);
    columnIds.get("1", 'guoziyun',{lang:lan}, function (status, responseText) {
        var list = JSON.parse(responseText);
        var html='';
        getColumnIds=list;
        for(var j = 0; j < list.length ; j++){
            var relateColumnId = list[j].id;
            if(getParameterByName("name")){
                if(getParameterByName("name")==list[j].title || getParameterByName("columnid")==list[j].id){
                    html+='<li class="ColumnsGrade" columnid='+relateColumnId+'><a class="grade1 active" href="list?columnid='+relateColumnId+'&name='+list[j].title+'">';
                }
                else{
                    html+='<li class="ColumnsGrade" columnid='+relateColumnId+'><a class="grade1" href="list?columnid='+relateColumnId+'&name='+list[j].title+'">';
                }
            }else{
                html+='<li class="ColumnsGrade" columnid='+relateColumnId+'><a class="grade1" href="list?columnid='+relateColumnId+'&name='+list[j].title+'">';
            }
            html+=''+list[j].title+'</a><ul class="tags-list" id="subject-list"></ul></li>';
            getSubject(list[j].id,j,list[j].title);
        }
        $('ul.demand').html(html);
        $('ul.demand .ColumnsGrade').mouseenter(function () {
            var i=$(this).index();
            $("ul.demand li ul#subject-list").css({"display":"none"});
            $(this).children("ul").css({"display":"inline-block","left":$(".ColumnsGrade")[0].offsetParent.offsetLeft+i*67+"px"});
            event.stopPropagation();
        });
        $('ul.demand .ColumnsGrade').mouseleave(function () {
            $("ul.demand li ul#subject-list").css({"display":"none"});
        });
    });
}
//获取学科
function getSubject(columnid,l,name) {
    var columnIds = epgColumn.init(ServerConfig.epgs,ServerConfig.epg);
    columnIds.get(columnid, 'guoziyun',{lang:lan}, function (status, responseText) {
        var htmlGrade = '';
        var grade = JSON.parse(responseText);
        for (var i = 0; i < grade.length; i++) {
            if(getParameterByName("columnid").length>5){
                if(grade[i].id==getParameterByName("columnid").substring(0,5)){
                    $(".path .subject").html(grade[i].title);
                }
            }
            htmlGrade += '<li class="ColumnsSubject" id="'+columnid+'"  gradeId="' + grade[i].id + '"><div onclick="jumpList(this)" columnid="'+columnid+'" name="'+name+'" class="'+ grade[i].id +' gradeColumn" gradeid="' + grade[i].id + '" title="' + grade[i].title + '">';
            if(grade[i].icon){
                htmlGrade += '<img src="'+grade[i].icon+'">';
            }else{
                htmlGrade += '<img src="public/images/subject.jpg">';
            }
            htmlGrade+='<a  href="list?columnid='+columnid+'&name='+name+'&subject='+grade[i].id+'" class="title">' + grade[i].title + '</a></div><ul class="tags-list chapter-list" id="'+grade[i].id+'"></ul></li>';
            getUnion(grade[i].id,i,columnid,name);
        }
        $(".ColumnsGrade").eq(l).children("#subject-list").html(htmlGrade);
        $('ul.demand .ColumnsGrade .ColumnsSubject').mouseenter(function (event) {
            var length=0,i=$(this).index();
            for(var j = 0; j < getColumnIds.length ; j++){
                if($(this).attr("id")==getColumnIds[j].id){
                    length=j;
                    break;
                }
            }
            $("ul.demand li ul.chapter-list").css({"display":"none"});
            $(this).parent("ul").siblings("a").addClass("onHover");
            $(this).children("ul").css({"display":"inline-block","left":$(".ColumnsGrade")[0].offsetParent.offsetLeft+(length*67)+143+"px","top":(i*40)+134+"px"});
            event.stopPropagation();
        });
        $("ul.demand .ColumnsGrade .ColumnsSubject").mouseleave(function () {
            $("ul.demand li ul.chapter-list").css({"display":"none"});
            $(this).parent("ul").siblings("a").removeClass("onHover");
        })
    });
}
//获取单元
function getUnion(id,l,columnid,name) {
    var columnIds = epgColumn.init(ServerConfig.epgs,ServerConfig.epg);
    columnIds.get(id, 'guoziyun',{lang:lan}, function (status, responseText) {
        var union = JSON.parse(responseText);
        var html = '';
        for(var k=0;k<union.length;k++){
            if(getParameterByName("columnid").length>5){
                if(union[k].id==getParameterByName("columnid")){
                    $(".path .unit").html(union[k].title);
                }
            }
            html+='<li id="'+union[k].id+'" class="ColumnsUnit"><a href="list?columnid='+columnid+'&name='+name+'&subject='+id+'&unit='+union[k].id+'" class="unionColumn" unionId=' + union[k].id + '>' + union[k].title + '</a></li>';
        }
        $("#"+id).html(html);
        $("ul.demand ul.chapter-list").mouseenter(function (event) {
            $(this).siblings("div").children("a").addClass("onHover");
            event.stopPropagation();
        })
        $("ul.demand  ul.chapter-list").mouseleave(function () {
            $(this).siblings("div").children("a").removeClass("onHover");
            $("ul.demand .li ul.chapter-list").css({"display":"none"});
        })
    })
}
function jumpList(el) {
    var name=$(el).attr("name"),columnid=$(el).attr("columnid"),subject=$(el).attr("gradeid");
    window.location.href='list?columnid='+columnid+'&name='+name+'&subject='+subject;
}
Date.prototype.format = function(){
    var o = {
        year: this.getFullYear(),
        month : this.getMonth()+1, //month
        day : this.getDate(), //day
        hour : this.getHours(), //hour
        minute : this.getMinutes() //minute
    };
    return o.year+"."+o.month+"."+o.day+"";
};

function logout() {
    $.post('media/logout?uin='+localStorage.getItem("uin")+'&signUin='+getCookie("signUin")+'&tin='+localStorage.getItem("tin")+'',function(data){
        //console.log(data);
        if(data.code==0){
            $(".my_center.f .f.ml-40").removeClass("displayNone");
            $(".my_center.f .hasLogin").addClass("displayNone");
            document.cookie ="signUin=";
            localStorage.removeItem("uin");
            localStorage.removeItem("tin");
            localStorage.removeItem("token");
        }
    })
}

function modify(uin,signUin,nickname,sex,photo,addr,country,postcode) {
    $.post("media/modify?uin="+uin+"&signUin="+signUin+"&nickname="+nickname+"&sex="+sex+"&photo="+photo+"&addr="+addr+"&country="+country+"&postcde="+postcode+"",function (data) {
        if(data.code==0){
            if(lan=="zh"){
                $(".tips").html("修改成功!");
            }else{
                $(".tips").html("modify success");
            }
            $(".tips").show();
            setTimeout(function () {
                $(".tips").hide();
                $(".edit-info").addClass("displayNone");
            },2000);
            setCookie();
            getInfo();
        }
    })
}
function getCookie(cookie_name)
{
    var allcookies = document.cookie;
    var cookie_pos = allcookies.indexOf(cookie_name);   //索引的长度
    // 如果找到了索引，就代表cookie存在，
    // 反之，就说明不存在。
    if (cookie_pos != -1)
    {
        // 把cookie_pos放在值的开始，只要给值加1即可。
        cookie_pos += cookie_name.length + 1;      //这里容易出问题，所以请大家参考的时候自己好好研究一下
        var cookie_end = allcookies.indexOf("=", cookie_pos);
        if (cookie_end == -1) {
            cookie_end = allcookies.length;
        }
        var value = unescape(allcookies.substring(cookie_pos, cookie_end));         //这里就可以得到你想要的cookie的值了。。。
    }
    return value;
}
function setCookie() {
    document.cookie="signUin="+ escape (getCookie("signUin")) + ";max-age=" + 15*60;
}
makeCode();
function makeCode() {
    new QRCode("detailCode", {
        text:ServerConfig.AndroidAddress,//任意内容
        correctLevel : QRCode.CorrectLevel.H
    });
    new QRCode("IOSCode", {
        text:ServerConfig.iPhoneAddress,//任意内容
        correctLevel : QRCode.CorrectLevel.H
    });
    new QRCode("detailCodeCopy", {
        text:ServerConfig.AndroidAddress,//任意内容
        correctLevel : QRCode.CorrectLevel.H
    });
    new QRCode("IOSCodeCopy", {
        text:ServerConfig.iPhoneAddress,//任意内容
        correctLevel : QRCode.CorrectLevel.H
    });
    //$("#detailCodeCopy,#detailCode").attr("title",'');
    $("#detailCodeCopy,#detailCode,#IOSCodeCopy,#IOSCode").attr("title",'');
}
$("#detailCode,#detailCodeCopy").parent(".code").click(function () {
    window.open(ServerConfig.AndroidAddress);
});
$("#IOSCode,#IOSCodeCopy").parent(".code").click(function () {
    window.open(ServerConfig.iPhoneAddress);
});
$(".download").parent("li").mouseenter(function() {
    $(".qrcode-box-wrp").show();
} );
$(".download").parent("li").mouseleave(function() {
    $(".qrcode-box-wrp").hide();
} );
$(".qrcode-box-wrp").mouseenter(function (event) {
    event.stopPropagation();
})
function IsChrome(){
    var ua = navigator.userAgent.toLocaleLowerCase();
    if (ua.match(/chrome/) != null) {
        var is360 = _mime("type", "application/vnd.chromium.remoting-viewer");
        function _mime(option, value) {
            var mimeTypes = navigator.mimeTypes;
            for (var mt in mimeTypes) {
                if (mimeTypes[mt][option] == value) {
                    return true;
                }
            }
            return false;
        }
        if (is360) {
            toChrome();
        }
    }else{
        toChrome();
    }
}

function toChrome() {
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            alert("当前不是Chrome浏览器,立即下载Chrome");
        }else{
            alert("Currently not a Chrome browser,download it now");
        }
    }else{
        alert("Currently not a Chrome browser,download it now");
    }
    window.location.href = ServerConfig.ChromeInstallationPath;
}

function getParameterByName (name) {
    name = name.replace(/[\[]/, '\\\[').replace(/[\]]/, '\\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)'),
        results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}