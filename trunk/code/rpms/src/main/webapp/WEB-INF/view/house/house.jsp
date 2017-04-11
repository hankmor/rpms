<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'"
         style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">编号：</td>
                    <td><input class="search-box" type="text" id="house-no" name="house-no"/></td>
                    <td style="min-width: 31px;">名称：</td>
                    <td><input style="height: 22px; width: 144px;" id="house-name" name="house-name"/></td>
                    <td style="min-width: 31px;">位置：</td>
                    <td><input style="height: 22px; width: 144px;" id="house-location" name="house-location"/></td>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="house-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="house-table"></table>
        <div id="house-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="house-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="javascript:void(0);" id="house-edit" class="easyui-linkbutton" iconCls="icon-edit"
                   plain="true">编辑</a>
                <a href="javascript:void(0);" id="house-delete" class="easyui-linkbutton" iconCls="icon-remove"
                   plain="true">删除</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/house/house.js" charset="utf-8"></script>
