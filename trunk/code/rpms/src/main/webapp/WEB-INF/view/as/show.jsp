<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <input type="hidden" id="animal-studbook-animalId" value="${animal.id}">

    <div data-options="title:'动物信息',region:'north',border:false,minHeight:65,maxHeight:65"
         style="padding:10px; height: 35px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <th style="width: 15%">编号：${animal.tatooCode}</th>
                <th style="width: 15%">芯片号：${animal.microchipCode}</th>
                <th style="width: 15%">谱系号：${animal.studbookCode}</th>
                <th style="width: 15%">呼名：${animal.name}</th>
                <th style="width: 15%">物种：${animal.animalType.name}</th>
            </table>
        </div>
    </div>
    <div data-options="region:'center', border:false">
        <div class="easyui-layout" data-options="fit:true">
            <div id="studbook-image-down" data-options="title:'子孙谱系视图',region:'west',border:false,split:true,collapsible:false" style="width:550px;padding:10px;"></div>
            <div id="studbook-image-up" data-options="title:'祖辈谱系视图',region:'center',border:false" style="padding: 10px;"></div>
        </div>
    </div>
</div>
<script language="javascript" src="${ctx}/assets/studbook/organization.js"></script>
<script type="text/javascript" src="${ctx}/assets/js/as/studbook.js" charset="utf-8"></script>