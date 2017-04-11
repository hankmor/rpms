<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="animal-transout-to-zoo" method="post" style="margin-top: 10px;">
    <table class="layout-table">
        <tr>
            <td style="text-align: right">动物芯片号：</td>
            <td><input type="text" readonly class="easyui-validatebox" style="width: 70%;" id="animal-chip-codes"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span>当前被转移动物的芯片号</span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">当前所在圈舍：</td>
            <td><input readonly type="text" class="easyui-validatebox" style="width: 70%;"
                       id="animal-cur-house-number"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span>当前被转移动物所在的圈舍编号</span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;"><span style="color: red;">*</span>目标园区：</td>
            <td><input name="zoo" style="width: 70%;" type="text" required="true" class="easyui-validatebox"
                       id="animal-transout-zoo"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span>当前需要转移到的园区名称</span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea style="width: 70%;height: 70px;" name="remark" class="easyui-validatebox"></textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        var rows = $('#house-transfer-table').datagrid('getChecked');

        var microchipCodes = $(rows).map(function (i, row) {
            return row.microchipCode;
        }).get().join(",");

        var ids = $(rows).map(function (i, row) {
            if (row.status == RED_PANDA.STATUS_FEEDING)
                return row.id;
        }).get().join(",");

        var houseNumbers = $(rows).map(function (i, row) {
            return row.houseNumber;
        }).get().join(",");

        $('#animal-chip-codes').val(microchipCodes);
        $('#animal-cur-house-number').val(houseNumbers);

        parent.$.messager.progress('close');
        $('#animal-transout-to-zoo').form({
            url: getContentPath() + '/ht/transOutToZoo.do',
            onSubmit: function (params) {
                params.ids = ids;
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
//                    Dialog.info(result.msg, '提示', function () {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
//                    });
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });
    });
</script>