<%--
  Created by IntelliJ IDEA.
  User: delyyfei
  Date: 2018/2/26
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<!--头部-->
<div class="top"></div>
<header>
    <div class="head">
        <div class="logo_area f">
            <h1 class="logo">
                <a href="" target="_self">
                    <img src="public/images/logo.png" alt="schoolnet" title="schoolnet"/>
                </a>
            </h1>
        </div>
        <div class="search_box f">
            <div class="search">
                <input type="text" placeholder="" id="search">
                <span class="r" style="margin:3px 4px 0 0;">
                    <a><i class="Hui-iconfont Hui-iconfont-search1" id="sub_search"></i></a>
                </span>
            </div>
        </div>
        <div class="my_center f">
            <div class="login f ml-40">
                <span class="Hui-iconfont Hui-iconfont-user2"></span>
                <a href="login" class="login_" id="userLogin"></a>
                <em style="color:#aaa" class="em">|</em>
                <a href="login?R=1" class="login_ reg"></a>
            </div>
            <div class="login f ml-40 hasLogin displayNone">
            </div>
            <div class="Log f ml-30">
                <span class="Hui-iconfont Hui-iconfont-shijian"></span>
                <a href="history" class="login_ history"></a>
            </div>
            <div class="ml-30 f">
                <span class="Hui-iconfont Hui-iconfont-cang2"></span>
                <a href="collect" class="login_ collect"></a>
            </div>
        </div>
        <div class="language f">
            <a class="active en" lang="en"></a>
            &nbsp;|&nbsp;
            <a class="zh" lang="zh"></a>
        </div>
    </div>
</header>

<div class="header-bottom"></div>
<!--导航区域-->
<nav>
    <div class="nav">
        <div class="nav-main">
            <ul class="demand">
            </ul>
        </div>
    </div>
</nav>
</body>
</html>
