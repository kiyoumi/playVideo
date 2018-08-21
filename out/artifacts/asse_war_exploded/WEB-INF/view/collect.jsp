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
                    <li class="active">
                        <a href="collect" class="active">
                            <i class="Hui-iconfont Hui-iconfont-cang2"></i>
                            <span class="text collect"></span>
                        </a>
                    </li>
                    <li>
                        <a href="history" >
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
<script type="text/javascript" src="public/js/jquery.cookie.js"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript" src="public/js/json2.min.js"></script>
<script type="text/javascript">
    var lan="en";
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
    getColumns();
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
    
    getCollection();

    function getCollection() {
        if(localStorage.getItem("time")){
            localStorage.removeItem("time");
        }
        $('.mod-figure').html("");
        if(getCookie("signUin")){
            var epgId=ServerConfig.epg;
            var result=[],enFavorite=[],zhFavorite=[];
            if(lan=="zh") {
                document.title="我的收藏";
                if(localStorage.getItem("zhFavorite")){
                    var zhF=JSON.parse(localStorage.getItem("zhFavorite"));
                    for(var o=0;o<zhF.length;o++){
                        if(zhF[o].userId==localStorage.getItem("uin")){
                            result.push(zhF[o]);
                        }
                    }

                }
            }else {
                document.title="Collection";
                if(localStorage.getItem("enFavorite")){
                    var enF=JSON.parse(localStorage.getItem("enFavorite"));
                    for(var o=0;o<enF.length;o++){
                        if(enF[o].userId==localStorage.getItem("uin")){
                            result.push(enF[o]);
                        }
                    }
                }
            }
            if(result.length>0){
                $('.nothing').css('display','none');
                for(var i = result.length-1 ; i >-1; i--){
                    var xml = '<li><a href="play?id='+result[i].mediaId+'&columnid='+result[i].columnId+'&title='+result[i].title+'"><div class="img">';
                    xml += '<img src='+result[i].image+' title='+result[i].title+'/>';
                    xml += '</div></a>';
                    xml += '<strong><a>'+result[i].title+'</a></strong>';
                    xml += '<div class="deleted-history"> <i class="Hui-iconfont" mediaId='+result[i].mediaId+' columnid='+result[i].columnId+' index="'+i+'">&#xe6a6;</i></div>';
                    xml += '</li>';
                    $(xml).appendTo('.mod-figure');
                    $('.deleted-history i').click(function () {
                        var mediaId=$(this).attr("mediaId");
                        var columnId=$(this).attr("columnid");
                        $(this).parents('li').remove();
                        if(localStorage.getItem("enFavorite")){
                            enFavorite=JSON.parse(localStorage.getItem("enFavorite"));
                            zhFavorite=JSON.parse(localStorage.getItem("zhFavorite"));
                            for(var k=0;k<enFavorite.length;k++) {
                                if (enFavorite[k].epgId == epgId && enFavorite[k].columnId == columnId && enFavorite[k].mediaId == mediaId) {
                                    enFavorite.splice(k,1);
                                    zhFavorite.splice(k,1);
                                    if(enFavorite.length==0){
                                        localStorage.removeItem("enFavorite");
                                        localStorage.removeItem("zhFavorite");
                                        $('.nothing').css('display','block');
                                    }else{
                                        localStorage.setItem("zhFavorite",JSON.stringify(zhFavorite));
                                        localStorage.setItem("enFavorite",JSON.stringify(enFavorite));
                                    }
                                }
                            }
                        }
                        //$(this).parents('li').fadeOut(300).remove(300);
                    })
                }
            }else{
                $('.nothing').css('display','block');
            }
        }else{
            $('.nothing').css('display','block');
        }
    }

    function CCH() {
        $(".site-container .user-box span.collect").html("我的收藏");
        $(".site-container .user-box span.history").html("观看记录");
        $(".site-container .user-box .center").html("个人中心");
        $(".site-container .user-box .nothing p").html("暂无收藏记录");
    }
    function CEN() {
        $(".site-container .user-box span.collect").html("collection");
        $(".site-container .user-box .center").html("Personal Center");
        $(".site-container .user-box .nothing p").html("Not available collection");
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
        getCollection();
        getInfo();
    })
</script>
</body>
</html>