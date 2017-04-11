<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="atta-update-form" method="post" style="margin-top: 10px;">
    <input type="hidden" name="id" value="${atta.id}">
    <table class="layout-table">
        <input type="hidden" name="id">
        <tr>
            <td style="text-align: right">文件名称：</td>
            <td><input style="width: 250px;" type="text" name="name" value="${atta.name}"></td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">描述：</td>
            <td><textarea name="description" style="width: 250px;height: 80px;">${atta.description}</textarea></td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea name="remark" style="width: 250px;height: 80px;">${atta.remark}</textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        parent.$.messager.progress('close');
        $('#atta-update-form').form({
            url: getContentPath() + '/atta/update.do',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
                    refreshTab();
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });
    });
</script>