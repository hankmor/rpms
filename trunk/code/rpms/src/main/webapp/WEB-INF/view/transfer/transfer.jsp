<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../common/tag.jsp" %>
<input type="hidden" id="house-transfer-house-id" value="${house.id}">

<div class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'"
         style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">编号：</td>
                    <td><input class="search-box" type="text" id="house-transfer-tatoono" name="house-transfer-tatoono"/></td>
                    <td style="min-width: 31px;">电子芯片号：</td>
                    <td><input class="search-box" type="text" id="house-transfer-no" name="house-transfer-no"/></td>
                    <td style="min-width: 31px;">呼名：</td>
                    <td><input style="height: 22px; width: 144px;" id="house-transfer-name" name="house-transfer-name"/>
                    </td>
                    <td style="min-width: 31px;">圈舍：</td>
                    <td><input style="height: 22px; width: 144px;" id="house" name="house"/></td>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="house-transfer-search" class="easyui-linkbutton"
                           iconCls="icon-search">查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="house-transfer-table"></table>
        <div id="house-transfer-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="house-transfer-transout-to-other-zoo" class="easyui-linkbutton"
                   iconCls="icon-remove"
                   plain="true">转到园区</a>
                <a href="javascript:void(0);" id="house-transfer-trans-out-to-house" class="easyui-linkbutton"
                   iconCls="icon-up" plain="true">转到圈舍</a>
                <a href="javascript:void(0);" id="house-transfer-trans-record" class="easyui-linkbutton"
                   iconCls="icon-book" plain="true">转移历史</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/house/transfer.js" charset="utf-8"></script>
