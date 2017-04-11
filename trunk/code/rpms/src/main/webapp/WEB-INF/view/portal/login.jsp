<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tag.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" type="text/css" href="${ctx}/assets/css/login.css">
    <title>用户登录</title>
</head>

<body>
<div class="login">
    <form method="post" action="${ctx}/j_spring_security_check">
        <div class="login_model">
            <div class="model_left">用户名：</div>
            <div class="model_right">
                <input class="inputlogin" type="text" name="j_username"/></div>
            <div class="clear"></div>
        </div>
        <div class="login_model">
            <div class="model_left"><span style="margin-right:1em;">密</span>码：</div>
            <div class="model_right"><input class="inputlogin" type="password" name="j_password" /></div>
            <div class="clear"></div>
        </div>
        <div class="login_model">
            <div class="model_right model_message">
                <span class="message-error">
                    <c:choose>
                        <c:when test="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message=='Bad credentials'}">
                            用户名或密码错误
                        </c:when>
                        <c:when test="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message=='permission denied'}">
                            没有登陆权限
                        </c:when>
                        <c:when test="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message=='user not found'}">
                            用户不存在或没有登录权限
                        </c:when>
                        <c:when test="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message=='account forbidden'}">
                            账户被禁用，请联系系统管理员
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        <div class="login_submit"><input class="btn btn-primary login-button buttonlogin" type="submit" value="登录" /></div>
    </form>
</div>
</body>
</html>
