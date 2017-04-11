<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<input type="hidden" value="${animalIds}" id="animal-ids">
<div class="easyui-layout" data-options="fit:true">
    <div data-options="title:'查询条件',region:'north',border:false,minHeight:60,maxHeight:100,closedTitle:'查询条件（点击展开）'"
         style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <tr>
                    <td style="min-width: 31px;">引物编号：</td>
                    <td>
                        <select name="primerIds" id="primerIds-table" style="width: 400px;"
                                class="easyui-combogrid"
                                data-options="
                                    panelWidth: 600,
                                    nowrap : true,
                                    multiple: true,
                                    pagination : false,
                                    rownumbers : true,
                                    fit : true,
                                    mode : 'remote',
                                    editable : false,
                                    idField: 'id',
                                    textField: 'no',
                                    url: getContentPath() + '/ag/cp/primers.do?animalIds=${animalIds}',
                                    method: 'post',
                                    frozenColumns: [
                                        [
                                            {
                                                field: 'id',
                                                align: 'center',
                                                checkbox: true
                                            }
                                        ]
                                    ],
                                    columns: [[
                                        {field: 'no', title: '引物编号', width: 70, align: 'center'},
                                        <%--{ field: 'genotypeCnt', title: '基因型数量', width: 40, align: 'center'},--%>
                                        <%--{ field: 'createUserName', title: '创建人', width: 60, align: 'center'},--%>
                                        <%--{ field: 'createTime', title: '创建时间', width: 80, align: 'center'},--%>
                                        <%--{ field: 'updateUserName', title: '最后修改人', width: 60, align: 'center'},--%>
                                        <%--{ field: 'updateTime', title: '修改时间', width: 80, align: 'center'},--%>
                                        { field: 'remark', title: '备注', width: 100, align: 'center'}
                                    ]],
                                    fitColumns: true,
                                    <%--toolbar : '#primer-search-toolbar',--%>
                                    <%--queryParams : {
                                        'no': $('#primer-no').searchbox('getValue')
                                    }--%>">
                        </select>
                        <%--<div id="primer-search-toolbar" style="padding:5px;">
                            <input id="primer-no" class="easyui-searchbox" style="width:120px">
                        </div>--%>
                    </td>
                    <%--<td>
                        <span style="color: red;">仅显示所选动物的引物</span>
                    </td>--%>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="genotype-animal-compare-search" class="easyui-linkbutton"
                           iconCls="icon-search">对比</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="genotype-animal-compare-table"></table>
       <%-- <table id="genotype-animal-compare-table" class="easyui-datagrid"
               data-options="title: '基因型对照表', singleSelect: true, rownumbers: true">
            <thead data-options="frozen:true">
                <tr>
                    <th rowspan="2" data-options="field:'tatooCode',width:30">编号</th>
                    <th rowspan="2" data-options="field:'microchipCode',width:100">芯片号</th>
                </tr>
            </thead>
            <thead>
                <tr>
                    <th colspan="2" data-options="width:200">引物</th>
                </tr>
                <tr>
                    <th data-options="width:100">基因型A</th>
                    <th data-options="width:100">基因型B</th>
                </tr>
            </thead>
            <tbody>
            &lt;%&ndash;<c:forEach items="${animals}" var="animal">
                <tr>
                    <td>${animal.tatooCode}</td>
                    <td>${animal.microchipCode}</td>
                    <td>${animal.animalType.name}</td>
                </tr>
            </c:forEach>&ndash;%&gt;
            </tbody>
        </table>--%>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/ag/compare.js" charset="utf-8"></script>
