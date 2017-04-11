<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${systemName}</title>
<%-- 引入bootstrap --%>
<link rel="stylesheet" type="text/css" href="${ctx}/asset-libs/bootstrap/css/bootstrap.min.css">
<%-- ace-file styles --%>
<link rel="stylesheet" href="${ctx}/asset-libs/css/ace-file.css" />
<%-- 引入EasyUI --%>
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/asset-libs/jquery-easyui/themes/<c:out value="${cookie.easyuiThemeName.value}" default="bootstrap"/>/easyui.css" type="text/css">
<link id="easyuiTheme" rel="stylesheet" href="${ctx}/asset-libs/jquery-easyui/themes/icon.css" type="text/css">
<%-- 引入EasyUI Portal插件 --%>
<link rel="stylesheet" href="${ctx}/asset-libs/jquery-easyui-portal/portal.css" type="text/css">
<link rel="stylesheet" href="${ctx}/assets/css/icon.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/assets/css/main.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/assets/css/edit-form.css" type="text/css" />