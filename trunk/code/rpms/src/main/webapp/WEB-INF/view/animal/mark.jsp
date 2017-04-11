<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="animal-mark-form" method="post" style="margin-top: 10px;">
    <table class="layout-table" cellpadding="4">
        <tr>
            <td style="text-align: right;width: 30%;"><span style="color: red;">*</span>编号：</td>
            <td><input type="text" style="width: 70%;" readonly class="easyui-validatebox" id="animal-mark-no-codes">
            </td>
        </tr>
        <tr>
            <td style="text-align: right;width: 30%;"><span style="color: red;">*</span>电子芯片号：</td>
            <td><input type="text" style="width: 70%;" readonly class="easyui-validatebox" id="animal-mark-chip-codes">
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;"><span style="color: red;">*</span>标记状态：</td>
            <td>
                <select class="easyui-combobox" style="width: 207px;" name="status" required="true">
                    <option></option>
                    <option value="2">死亡</option>
                </select>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td colspan="3">
                <textarea style="width: 70%;height: 60px;" name="remark"></textarea>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        var rows = $('#red-panda-table').datagrid('getChecked');

        var microchipCodes = $(rows).map(function (i, row) {
            return row.microchipCode;
        }).get().join(",");

        var noCodes = $(rows).map(function (i, row) {
            return row.tatooCode;
        }).get().join(",");

        var ids = $(rows).map(function (i, row) {
            if (row.status == RED_PANDA.STATUS_FEEDING)
                return row.id;
        }).get().join(",");

        $('#animal-mark-chip-codes').val(microchipCodes);
        $('#animal-mark-no-codes').val(noCodes);

        parent.$.messager.progress('close');
        $('#animal-mark-form').form({
            url: getContentPath() + '/rp/mark.do',
            onSubmit: function (param) {
                param.ids = ids;
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