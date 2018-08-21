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
    <title>个人中心</title>
    <link rel="icon" href="public/images/logo.png" type="image/x-icon"/>
    <link href="public/Icon/iconfont.css" rel="stylesheet">
    <link rel="stylesheet" href="public/css/details.css?v=${version}"/>
    <link rel="stylesheet" href="public/css/user-info.css?v=${version}"/>
    <link rel="stylesheet" href="public/css/my-center.css?v=${version}">
    <link rel="stylesheet" href="public/css/Common.css?v=${version}">
</head>
<body>
<!--头部-->
<jsp:include page="head.jsp" flush="true"/>
<div class="site-container">
    <div class="user-box choose">
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
                    <li>
                        <a href="history" >
                            <i class="Hui-iconfont Hui-iconfont-shijian"></i>
                            <span class="text history"></span>
                        </a>
                    </li>
                    <li class="active">
                        <a href="myCenter" class="active">
                            <i class="Hui-iconfont Hui-iconfont-avatar2"></i>
                            <span class="text center"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <!--导航栏结束-->
        <!--个人信息开始-->
        <div class="main-content">
            <div id="setting-profile" class="setting-wrap setting-profile">
                <div class="common-title">
                </div>
                <div class="line"></div>
                <div class="info-wapper">
                    <div class="info-box clearfix NIKE">
                        <label class="fl"></label><div class="fl nickname">kimi</div>
                    </div>
                    <div class="info-box clearfix SEX">
                        <label class="fl"></label><div class="fl sex"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--页脚-->
<jsp:include page="footer.jsp" flush="true"/>
<div>
    <div class="edit-info displayNone">
        <div class="editP">
            <div class="titleT"><span></span><a href="javascript:void(0)" class="close fr"><i class="Hui-iconfont Hui-iconfont-close"></i></a></div>
            <form class="js-wapper-form" id="profile">
                <div class="form-group NI">
                    <label class="control-label"></label>
                    <div class="control-input">
                        <input type="text" name="nickname" id="nick" autocomplete="off" data-validate="require-nick" class="form-control" value="" placeholder="">
                        <div class="rlf-tip-wrap errorHint color-red"></div>
                    </div>
                </div>
                <div class="form-group wlfg-wrap SE">
                    <label class="control-label h16 lh16"></label>
                    <div class="control-input rlf-group rlf-radio-group sex">
                        <label class="male"></label>
                        <label class="female"></label>
                        <div class="rlf-tip-wrap errorHint color-red"></div>
                    </div>
                </div>
                <div class="wlfg-wrap clearfix">
                    <label class="control-label"></label>
                    <div class="control-input">
                        <a href="javascript:void(0);" id="profile-submit">确定</a>
                        <a href="javascript:void(0);" id="cancel">取消</a>
                    </div>
                </div>
            </form>
            <div class="tips" style="display: none">
                <a>修改成功</a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="public/js/jquery.js"></script>
<script type="text/javascript" src="public/js/qrcode.min.js"></script>
<script type="text/javascript" src="public/js/config.js?v=${version}"></script>
<script type="text/javascript" src="public/js/main.js?v=${version}"></script>
<script type="text/javascript" src="public/js/Epgs/libcolumn.js"></script>
<script type="text/javascript">
    var lan="en";
    if(localStorage.getItem("lang")){
        lan=localStorage.getItem("lang");
        if(lan=="zh"){
            $(".zh").addClass("active").siblings().removeClass("active");
            CH();
            $("footer ._footer").eq(1).removeClass("displayNone").addClass("choose").siblings().addClass("displayNone").removeClass("choose");
            CCH();
        }else {
            EN();
            CEN();
        }
    }else {
        EN();
        CEN();
    }
    getInfo();
    getColumns();

    if(localStorage.getItem("time")){
        localStorage.removeItem("time");
    }

    $('#sub_search').click(function() {
        var title = $('#search').val();
        if (title != '' && title != null) {
            window.location.href='search?wd=' + title;
        }else{
            $("#search").focus();
        }
    });

    $("#cancel,.edit-info.choose .close").unbind("click").bind("click",function () {
        $(".edit-info").addClass("displayNone");
    })

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

    function CCH() {
        document.title="个人中心";
        $(".site-container .user-box span.collect").html("我的收藏");
        $(".site-container .user-box span.history").html("观看记录");
        $(".site-container .user-box .center").html("个人中心");
        $(".site-container .setting-wrap .common-title").html('个人信息<a href="javascript: void(0);" class="fr js-edit-info"><i class="Hui-iconfont Hui-iconfont-edit"></i>编辑</a>');
        $(".site-container .setting-wrap .info-wapper .NIKE label").html('昵称');
        $(".site-container .setting-wrap .info-wapper .SEX label").html('性别');
        $(".site-container .setting-wrap .info-wapper .SEX .sex").html('男');
        $(".edit-info .editP .titleT span").html('编辑个人信息');
        $(".edit-info .editP .NI label").html('昵称：');
        $(".edit-info .editP .NI #nick").attr("placeholder","请输入昵称");
        $(".edit-info .editP .SE label.h16").html('性别：');
        $(".edit-info .editP .SE label.male").html('<input type="radio" hidefocus="true" value="1" name="sex">男');
        $(".edit-info .editP .SE label.female").html('<input type="radio" hidefocus="true" value="2" name="sex">女');
        $(".edit-info .editP #profile-submit").html('确定');
        $(".edit-info .editP #cancel").html('取消');

    }
    function CEN() {
        document.title="Personal Center";
        $(".site-container .user-box span.collect").html("collection");
        $(".site-container .user-box .center").html("Personal Center");
        $(".site-container .setting-wrap .common-title").html('Personal information<a href="javascript: void(0);" class="fr js-edit-info"><i class="Hui-iconfont Hui-iconfont-edit"></i>edit</a>');
        $(".site-container .setting-wrap .info-wapper .NIKE label").html('Nickname');
        $(".site-container .setting-wrap .info-wapper .SEX label").html('Sex');
        $(".site-container .setting-wrap .info-wapper .SEX .sex").html('male');
        $(".edit-info .editP .titleT span").html('Edit personal information');
        $(".edit-info .editP .NI label").html('Nickname：');
        $(".edit-info .editP .NI #nick").attr("placeholder","Enter nickname");
        $(".edit-info .editP .SE label.h16").html('Sex：');
        $(".edit-info .editP .SE label.male").html('<input type="radio" hidefocus="true" value="1" name="sex">male');
        $(".edit-info .editP .SE label.female").html('<input type="radio" hidefocus="true" value="2" name="sex">female');
        $(".edit-info .editP #profile-submit").html('Submit');
        $(".edit-info .editP #cancel").html('Cancel');

    }

    $(".language a").bind("click",function () {
        lan=$(this).attr("lang");
        if(lan=="zh"){
            CH()
            $("footer ._footer").eq(1).removeClass("displayNone").addClass("choose").siblings().addClass("displayNone").removeClass("choose");
            CCH();
        }else{
            EN();
            $("footer ._footer").eq(0).removeClass("displayNone").addClass("choose").siblings().addClass("displayNone").removeClass("choose");
            CEN();
        }
        $(this).addClass("active").siblings().removeClass("active");
        localStorage.setItem("lang",lan);
        getInfo();
    })

</script>
</body>
</html>