<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <input type="hidden" id="animal-exam-animalId" value="${animal.id}">

    <div data-options="title:'动物信息',region:'north',border:false,minHeight:100,maxHeight:100"
         style="padding:10px; height: 75px;">
        <%-- Search Area --%>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <table>
                <th style="width: 15%">编号：${animal.tatooCode}</th>
                <th style="width: 15%">芯片号：${animal.microchipCode}</th>
                <th style="width: 15%">谱系号：${animal.studbookCode}</th>
                <th style="width: 15%">呼名：${animal.name}</th>
                <th style="width: 15%">物种：${animal.animalType.name}</th>
            </table>
            <hr style="margin: 5px 0;padding: 0"/>
            <table>
                <tr>
                    <td style="min-width: 31px;">体检时间：</td>
                    <td><input type="text" id="animal-exam-beginTime" class="easyui-datebox"/></td>
                    <td style="min-width: 12px;">到</td>
                    <td><input type="text" id="animal-exam-endTime" class="easyui-datebox"/></td>
                    <td style="min-width: 170px;">
                        <a href="javascript:void(0);" id="animal-exam-search" class="easyui-linkbutton"
                           iconCls="icon-search">查询</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div data-options="region:'center',border:false">
        <%-- Table Area --%>
        <table id="animal-exam-table"></table>
        <div id="exam-animal-toolbar" style="padding:5px;">
            <div>
                <a href="javascript:void(0);" id="exam-animal-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="javascript:void(0);" id="exam-animal-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
                <a href="javascript:void(0);" id="exam-animal-delete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
                <a href="javascript:void(0);" id="exam-animal-facade" class="easyui-linkbutton" iconCls="icon-photo" plain="true">外观特征</a>
                <a href="javascript:void(0);" id="exam-animal-wound" class="easyui-linkbutton" iconCls="icon-exam" plain="true">受伤情况</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/ae/ae.js" charset="utf-8"></script>
