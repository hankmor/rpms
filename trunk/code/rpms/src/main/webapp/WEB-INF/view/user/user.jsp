<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div id="score-layout" class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'" style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">用户名：</td>
                    <td><input class="search-box" type="text" id="feeder-username" name="feeder-username" /></td>
                    <td style="min-width: 31px;">姓名：</td>
                    <td><input id="feeder-trueName" name="feeder-trueName" /></td>
                    <td>
                        <a href="javascript:void(0);" id="feeder-search" class="easyui-linkbutton" iconCls="icon-search" >查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="feeder-table"></table>
        <div id="feeder-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="feeder-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="javascript:void(0);" id="feeder-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
                <a href="javascript:void(0);" id="feeder-delete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
                <a href="javascript:void(0);" id="feeder-using" class="easyui-linkbutton" iconCls="icon-userEnable" plain="true">启用</a>
                <a href="javascript:void(0);" id="feeder-forbidden" class="easyui-linkbutton" iconCls="icon-userForbidden" plain="true">禁用</a>
                <a href="javascript:void(0);" id="feeder-resetpwd" class="easyui-linkbutton" iconCls="icon-resetPwd" plain="true">重置密码</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/user/user.js" charset="utf-8"></script>
