<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.getSession().getServletContext().setAttribute("ctx", request.getContextPath());
    request.getSession().setAttribute("systemName", "小熊猫、丹顶鹤微卫星数据管理系统");
%>
<script type="text/javascript">
    var ctx = '<%=request.getContextPath()%>';
</script>