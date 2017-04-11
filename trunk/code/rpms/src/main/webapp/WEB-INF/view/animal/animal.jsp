<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'" style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">编号：</td>
                    <td><input class="search-box" type="text" id="red-panda-no" name="red-panda-no" /></td>
                    <td style="min-width: 31px;">电子芯片号：</td>
                    <td><input class="search-box" type="text" id="red-panda-microchip-no" name="red-panda-microchip-no" /></td>
                    <td style="min-width: 31px;">呼名：</td>
                    <td><input style="height: 22px; width: 144px;" id="red-panda-name" name="red-panda-name" /></td>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="red-panda-search" class="easyui-linkbutton" iconCls="icon-search" >查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="red-panda-table"></table>
        <div id="red-panda-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="red-panda-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="javascript:void(0);" id="red-panda-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
                <a href="javascript:void(0);" id="red-panda-mark" class="easyui-linkbutton" iconCls="icon-edit1" plain="true">标记</a>
                <a href="javascript:void(0);" id="red-panda-delete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
                <a href="javascript:void(0);" id="red-panda-photo" class="easyui-linkbutton" iconCls="icon-photo" plain="true">照片管理</a>
                <a href="javascript:void(0);" id="red-panda-exam" class="easyui-linkbutton" iconCls="icon-exam" plain="true">体检管理</a>
                <a href="javascript:void(0);" id="red-panda-studbook" class="easyui-linkbutton" iconCls="icon-studbook" plain="true">谱系分析</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/animal/animal.js" charset="utf-8"></script>
