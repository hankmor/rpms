<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <c:forEach items="${attas}" var="p" varStatus="i" >
                <li data-target="#carousel-example-generic" data-slide-to="${i.index}"></li>
            </c:forEach>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <c:forEach items="${attas}" var="p" varStatus="i">
                <div class="item ${i.index == 0 ? 'active' : ''}">
                    <img alt="${p.name}" src="${p.url}" style="width: auto; height: 100%; display: block; clear: both;margin: auto;">
                    <div class="carousel-caption">
                        <h3>${p.name}</h3>
                        <p>${p.description}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        parent.$.messager.progress('close');
        $('.carousel').carousel({
            interval: 2000
        })
    });
</script>
