<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'"
         style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">编号：</td>
                    <td><input class="search-box" type="text" id="primer-no" name="primer-no"/></td>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="primer-search" class="easyui-linkbutton"
                           iconCls="icon-search">查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="primer-table"></table>
        <div id="primer-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="primer-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="javascript:void(0);" id="primer-edit" class="easyui-linkbutton" iconCls="icon-edit"
                   plain="true">编辑</a>
                <a href="javascript:void(0);" id="primer-delete" class="easyui-linkbutton" iconCls="icon-remove"
                   plain="true">删除</a>
                <%--<a href="javascript:void(0);" id="primer-add-genotype" class="easyui-linkbutton" iconCls="icon-add"
                   plain="true">添加基因型</a>--%>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/primer/primer.js" charset="utf-8"></script>
