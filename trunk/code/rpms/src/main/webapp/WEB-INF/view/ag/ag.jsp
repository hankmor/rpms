<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'"
         style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">编号：</td>
                    <td><input class="search-box" type="text" id="genotype-animal-no"/></td>
                    <td style="min-width: 31px;">芯片号：</td>
                    <td><input class="search-box" type="text" id="genotype-animal-chipNo"/></td>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="genotype-animal-search" class="easyui-linkbutton"
                           iconCls="icon-search">查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="genotype-animal-table"></table>
        <div id="ag-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="ag-compare" class="easyui-linkbutton" iconCls="icon-add" plain="true">对比基因型</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/ag/ag.js" charset="utf-8"></script>
