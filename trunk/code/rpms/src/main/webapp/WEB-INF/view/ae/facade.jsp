<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="easyui-layout" data-options="fit:true">
    <input type="hidden" id="facade-exam-id" value="${exam.id}">
    <div data-options="region:'center',title:'外观照片列表',border:false">
        <div style="padding: 10px;margin-top: 10px;">
            <table style="width: 100%">
                <tr>
                    <td style="width: 20%;"><label>编号：${exam.animal.tatooCode}</label></td>
                    <td style="width: 20%;"><label>芯片号：${exam.animal.microchipCode}</label></td>
                    <td style="width: 20%;"><label>呼名：${exam.animal.name}</label></td>
                    <td style="width: 20%;"><label>体检记录号：${exam.id}</label></td>
                    <td style="width: 20%;"><label>体检日期：<fmt:formatDate value="${exam.examTime}" pattern="yyyy-MM-dd HH:mm"/></label></td>
                    <td style="width: 20%;min-width: 170px;">
                        <a href="#" style="float: right" class="easyui-linkbutton" id="facade-upload"
                           data-options="iconCls:'icon-upload'">上传外观特征照片</a>
                    </td>
                </tr>
            </table>
        </div>
        <hr style="margin: 0 0 10px 0;">
        <div class="row" style="padding: 5px;">
            <c:if test="${fn:length(facades) == 0}">
                <h2 style="color:#CCC;text-align: center;vertical-align: middle">暂无外观特征数据.</h2>
            </c:if>
            <c:forEach items="${facades}" var="p">
                <div class="col-sm-6 col-md-3 col-xs-3">
                    <input type="hidden" name="id" value="${p.id}">

                    <div class="thumbnail">
                        <img class="animal-photo" alt="${p.name}" src="${p.url}"
                             style="height: 220px; width: 100%; display: block;cursor: pointer;">

                        <div class="caption">
                            <h4><a href="${p.url}" target="_blank">${p.name}</a></h4>

                            <p>${p.description}</p>

                            <p>上传时间：${p.uploadTime}</p>

                            <p>文件大小：${p.sizeText}</p>

                            <p>备注信息：${p.remark}</p>

                            <p style="text-align: center;">
                                <a href="javascript:void(0);" class="easyui-linkbutton edit-btn"
                                   data-options="iconCls:'icon-edit'">修改</a>
                                <a href="javascript:void(0);" class="easyui-linkbutton delete-btn"
                                   data-options="iconCls:'icon-errorRed'">删除</a>
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/assets/js/ae/facade.js" charset="utf-8"></script>
