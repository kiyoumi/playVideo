<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/WEB-INF/view/lib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title></title>
    <link href="public/Icon/iconfont.css" rel="stylesheet">
    <link href="public/css/Common.css?v=${version}" rel="stylesheet">
    <link rel="icon" href="public/images/logo.png" type="image/x-icon"/>
    <link rel="stylesheet" href="public/css/details.css?v=${version}"/>
    <link rel="stylesheet" href="public/css/user-info.css?v=${version}"/>
</head>
<body>

<!--头部-->
<jsp:include page="head.jsp" flush="true"/>

<div class="site-container">
    <div class="user-box">
        <!--导航栏-->
        <div class="contain-guide">
            <div class="user-navigate">
                <div class="user-info">
                    <div class="navi-avater">
                        <img src="public/images/touxiang.jpg"/>
                        <div class="vip-box">
                            <img src="public/images/vip.jpg" alt=""/>
                        </div>
                    </div>
                    <div class="user-name mt-10">
                        <span>kimi</span>
                    </div>
                    <%--<div class="open-up-vip mt-10">                        <span>开通会员 大片抢先看</span>                        <a href="produce?columnid=991">立即开通</a>                    </div>--%>
                </div>
                <ul>
                    <li>
                        <a href="collect">
                            <i class="Hui-iconfont Hui-iconfont-cang2"></i>
                            <span class="text collect"></span>
                        </a>
                    </li>
                    <li class="active">
                        <a href="history" class="active" >
                            <i class="Hui-iconfont Hui-iconfont-shijian"></i>
                            <span class="text history"></span>
                        </a>
                    </li>
                    <li>
                        <a href="myCenter">
                            <i class="Hui-iconfont Hui-iconfont-avatar2"></i>
                            <span class="text center"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <!--导航栏结束-->
        <!--观看历史开始-->
        <div class="main-content">
            <!--无数据显示-->
            <div class="nothing">
                <i class="Hui-iconfont Hui-iconfont-bofang"></i>
                <p></p>
            </div>
            <!--收藏-->

            <div class="collect-box">
                <div class="collect">
                    <ul class="mod-figure">

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>
<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main-mini.js?v=${version}"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/jquery.cookie.js"></script>
<script type="text/javascript" src="public/js/json2.min.js"></script>
<script type="text/javascript">
    var lan="en";
    $(function () {
        if(localStorage.getItem("lang")){
            lan=localStorage.getItem("lang");
            if(lan=="zh"){
                $(".zh").addClass("active").siblings().removeClass("active");
                CH()
                $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
                CCH();
            }else{
                EN();
                CEN();
            }
        }else{
            EN();
            CEN();
        }
        getInfo();
        getHistory();
        getColumns();
        var str = $(".synopsis span").text();
        var s = str;
        if(str.length>200){
            s=str.substring(0,200)+"...";
            $(".synopsis span").text(s);
            if(lan=="zh"){
                $("<a style='cursor: pointer' class='Show-More'>显示更多</a>").appendTo(".synopsis span");
            }else{
                $("<a style='cursor: pointer' class='Show-More'>Show more</a>").appendTo(".synopsis span");
            }
            $(".Show-More").click(function () {
                $(".synopsis span").text(str);
            })
        }
    });

    function CCH() {
        $(".site-container .user-box span.collect").html("我的收藏");
        $(".site-container .user-box span.history").html("观看记录");
        $(".site-container .user-box .center").html("个人中心");
        $(".site-container .user-box .nothing p").html("暂无观看记录");
    }
    function CEN() {
        $(".site-container .user-box span.collect").html("collection");
        $(".site-container .user-box .center").html("Personal Center");
        $(".site-container .user-box .nothing p").html("Not available history");
    }

    //播放记录
    function getHistory() {
        $('.mod-figure').html("");
        if(localStorage.getItem("time")){
            localStorage.removeItem("time");
        }
        if(getCookie("signUin")){
            var epgId=ServerConfig.epg;
            var resultText=[],enHistory=[],zhHistory=[];
            if(lan=="zh") {
                document.title="观看记录";
                if(localStorage.getItem("zhHistory")){
                    var zhH=JSON.parse(localStorage.getItem("zhHistory"));
                    for(var o=0;o<zhH.length;o++){
                        if(zhH[o].userId==localStorage.getItem("uin")){
                            resultText.push(zhH[o]);
                        }
                    }
                }
            }else {
                document.title="History";
                if(localStorage.getItem("enHistory")){
                    var enH=JSON.parse(localStorage.getItem("enHistory"));
                    for(var o=0;o<enH.length;o++){
                        if(enH[o].userId==localStorage.getItem("uin")){
                            resultText.push(enH[o]);
                        }
                    }
                }
            }
            if(resultText.length>0){
                $('.nothing').css('display','none');
                for(var i = resultText.length-1 ; i >-1; i--){
                    var time = parseInt(resultText[i].time);
                    var theTime1 = 0;// 分
                    var theTime2 = 0;// 小时
                    if(time > 60) {
                        theTime1 = parseInt(time/60);
                        time = parseInt(time%60);
                        if(theTime1 > 60) {
                            theTime2 = parseInt(theTime1/60);
                            theTime1 = parseInt(theTime1%60);
                        }
                    }
                    if(lan=="zh"){
                        var result = ""+parseInt(time)+"秒";
                        if(theTime1 > 0) {
                            result = ""+parseInt(theTime1)+"分"+result;
                        }
                        if(theTime2 > 0) {
                            result = ""+parseInt(theTime2)+"小时"+result;
                        }
                    }else{
                        var result = " "+parseInt(time)+" seconds";
                        if(theTime1 > 0) {
                            result = " "+parseInt(theTime1)+" minutes"+result;
                        }
                        if(theTime2 > 0) {
                            result = " "+parseInt(theTime2)+" hours"+result;
                        }
                    }
                    var seria = parseInt(resultText[i].seria)+1;
                    var html = '<li><a href="play?id='+ resultText[i].mediaId + '&columnid='+ resultText[i].columnId +'&title='+resultText[i].title+'&d_num='+seria+'"><div class="img">';
                    html += '<img src="'+resultText[i].image+'" title="'+resultText[i].title+'"/></div>';
                    html += '<strong><a href="play?id='+ resultText[i].mediaId + '&columnid='+ resultText[i].columnId + '&title='+resultText[i].title+'&d_num='+seria+'">'+resultText[i].title+'</a></strong>';
                    if(resultText[i].meta==1){
                        if(lan=="zh"){
                            html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>观看至'+result+'</p>'
                        }else{
                            html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>Watch for'+result+'</p>'
                        }

                    }else{
                        if(lan=="zh"){
                            html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>观看至第' + seria + '集' + result + '</p>'
                        }else{
                            html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>Watch the ' + seria + ' episode' + result + '</p>'
                        }
                    }
                    html += '<div class="deleted-history"><i class="Hui-iconfont Hui-iconfont-close" index="'+i+'"  mediaId="'+resultText[i].mediaId+'" columnid="'+resultText[i].columnId+'"></i></div></li>'
                    $(html).appendTo('.mod-figure');
                    $('.deleted-history i').click(function () {
                        var mediaId=$(this).attr("mediaId");
                        var columnId=$(this).attr("columnid");
                        $(this).parents('li').remove();
                        if(localStorage.getItem("enHistory")){
                            enHistory=JSON.parse(localStorage.getItem("enHistory"));
                            zhHistory=JSON.parse(localStorage.getItem("zhHistory"));
                            console.log(enHistory);
                            for(var k=0;k<enHistory.length;k++) {
                                if (enHistory[k].epgId == epgId && enHistory[k].columnId == columnId && enHistory[k].mediaId == mediaId && enHistory[k].userId==localStorage.getItem("uin")) {
                                    enHistory.splice(k,1);
                                    zhHistory.splice(k,1);
                                    if(enHistory.length==0){
                                        localStorage.removeItem("enHistory");
                                        localStorage.removeItem("zhHistory");
                                        $('.nothing').css('display','block');
                                    }else{
                                        localStorage.setItem("zhHistory",JSON.stringify(zhHistory));
                                        localStorage.setItem("enHistory",JSON.stringify(enHistory));
                                    }
                                }
                            }
                        }
                    })
                }
            }else{
                $('.nothing').css('display','block');
            }
        }else{
            $('.nothing').css('display','block');
        }

        /*var epgId=ServerConfig.epg;
        var _url='';
        var userId=localStorage.getItem("uin");
        $('.mod-figure').html("");
        _url += 'http://'+ServerConfig.commentServer+':8080/cts/playrecord/get?userId=' + userId + '&lang='+lan+'&token=guoziyun';
        $.get(_url, function(resultText) {
            console.log(resultText);
            if(resultText != null){
                if(resultText.length>0){
                    $('.nothing').css('display','none');
                    for(var i = resultText.length-1 ; i >-1; i--){
                        var time = parseInt(resultText[i].time);
                        var theTime1 = 0;// 分
                        var theTime2 = 0;// 小时
                        if(time > 60) {
                            theTime1 = parseInt(time/60);
                            time = parseInt(time%60);
                            if(theTime1 > 60) {
                                theTime2 = parseInt(theTime1/60);
                                theTime1 = parseInt(theTime1%60);
                            }
                        }
                        if(lan=="zh"){
                            var result = ""+parseInt(time)+"秒";
                            if(theTime1 > 0) {
                                result = ""+parseInt(theTime1)+"分"+result;
                            }
                            if(theTime2 > 0) {
                                result = ""+parseInt(theTime2)+"小时"+result;
                            }
                        }else{
                            var result = " "+parseInt(time)+" seconds";
                            if(theTime1 > 0) {
                                result = " "+parseInt(theTime1)+" minutes"+result;
                            }
                            if(theTime2 > 0) {
                                result = " "+parseInt(theTime2)+" hours"+result;
                            }
                        }
                        var seria = parseInt(resultText[i].seria)+1;
                        var html = '<li><a href="play?id='+ resultText[i].mediaId + '&columnid='+ resultText[i].columnId +'&title='+resultText[i].title+'&d_num='+seria+'"><div class="img">';
                        html += '<img src="'+resultText[i].image+'" title="'+resultText[i].title+'"/></div>';
                        html += '<strong><a href="play?id='+ resultText[i].mediaId + '&columnid='+ resultText[i].columnId + '&title='+resultText[i].title+'&d_num='+seria+'">'+resultText[i].title+'</a></strong>';
                        if(resultText[i].meta==6){
                            if(lan=="zh"){
                                html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>观看至'+result+'</p>'
                            }else{
                                html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>Watch for'+result+'</p>'
                            }

                        }else{
                            if(lan=="zh"){
                                html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>观看至第' + seria + '集' + result + '</p>'
                            }else{
                                html += '<p><i class="Hui-iconfont Hui-iconfont-xianshiqi"></i>Watch the ' + seria + ' episode' + result + '</p>'
                            }
                        }
                        html += '<div class="deleted-history"><i class="Hui-iconfont Hui-iconfont-close" index="'+i+'"  mediaId="'+resultText[i].mediaId+'"></i></div></li>'
                        $(html).appendTo('.mod-figure');
                        $('.deleted-history i').click(function () {
                            var _url = "";
                            var indexs=$(this).attr('index');
                            _url += 'http://' + ServerConfig.commentServer + ':8080/cts/playrecord/delete';
                            $.post(_url, {
                                "userId": userId,
                                "indexs": indexs,
                                "token": "guoziyun"
                            }, function (data) {
                                console.log(data);
                                window.location.href = 'history';
                            });
                            $(this).parents('li').fadeOut(300).remove(300);
                            if($('.mod-figure li').length<1){
                                $('.nothing').css('display','block');
                            }
                        })
                    }
                }else{
                    $('.nothing').css('display','block');
                }
            }
        })*/
    }


    //点击搜索
    $('#sub_search').click(function() {
        var title = $('#search').val();
        if (title != '' && title != null) {
            window.location.href='search?wd=' + title;
        }else{
            $("#search").focus();
        }
    });
    document.onkeydown = function(event) {
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if (e && e.keyCode == 13) {
            var title = $('#search').val();
            if (title != '') {
                window.location.href='search?wd=' + title;
            }
            if (title == '') {
                return false;
            }
        }
    }
    $(".language a").bind("click",function () {
        lan=$(this).attr("lang");
        if(lan=="zh"){
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").siblings().addClass("displayNone");
            CCH();
        }else{
            EN();
            $("footer ._footer").eq(0).removeClass("displayNone").siblings().addClass("displayNone");
            CEN();
        }
        $(this).addClass("active").siblings().removeClass("active");
        localStorage.setItem("lang",lan);
        getHistory();
        getInfo();
    })
</script>
</body>
</html>