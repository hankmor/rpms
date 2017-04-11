<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="primer-add-form" method="post" style="margin-top: 10px;">
    <table class="layout-table">
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>编号：</td>
            <td><input name="no" type="text" class="easyui-validatebox" validType="sameNo['/primer/same.do']"
                       data-options="required:true"></td>
        </tr>
        <tr>
            <td></td>
            <td>确定后不能修改</td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea style="width: 153px;" name="remark" class="easyui-validatebox"></textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        parent.$.messager.progress('close');
        $('#primer-add-form').form({
            url: getContentPath() + '/primer/add.do',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
                    //Dialog.info(result.msg,'提示',function(){
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    //});
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });
    });
</script>