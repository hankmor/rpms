<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="animal-exam-add-form" method="post" style="margin-top: 10px;">
    <input type="hidden" name="animal.id" id="add-animal-exam-animalId" value="${animal.id}">
    <table class="layout-table">
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>动物编号：</td>
            <td>
                <input type="text" readonly value="${animal.tatooCode}" class="easyui-validatebox" required="true">
            </td>
        </tr>
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>动物芯片号：</td>
            <td>
                <input type="text" readonly value="${animal.microchipCode}" class="easyui-validatebox">
            </td>
        </tr>
        <tr>
            <td style="text-align: right">体重：</td>
            <td>
                <input type="text" name="weight" class="easyui-validatebox" validType="number[true]">kg
            </td>
        </tr>
        <tr>
            <td style="text-align: right">体长：</td>
            <td>
                <input type="text" name="bodyLength" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">吻长：</td>
            <td>
                <input type="text" name="coutourLength" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">耳长：</td>
            <td>
                <input type="text" name="earLength" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">尾长：</td>
            <td>
                <input type="text" name="tailLength" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">颈围：</td>
            <td>
                <input type="text" name="neckGirth" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">胸围：</td>
            <td>
                <input type="text" name="chestGirth" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">腹围：</td>
            <td>
                <input type="text" name="abdominalGirth" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">左前肢长度：</td>
            <td>
                <input type="text" name="leftFrontLegLength" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">左后肢长度：</td>
            <td>
                <input type="text" name="leftBackLegLength" class="easyui-validatebox" validType="number[true]">cm
            </td>
        </tr>
        <tr>
            <td style="text-align: right">体温：</td>
            <td>
                <input type="text" name="temperature" class="easyui-validatebox" validType="number[true]">℃
            </td>
        </tr>
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>体检员：</td>
            <td>
                <input type="text" name="examUser" class="easyui-validatebox" required="true">
            </td>
        </tr>
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>体检时间：</td>
            <td>
                <input type="text" name="examTime" class="easyui-datetimebox" data-options="required:true,showSeconds:false">
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top">备注：</td>
            <td>
                <textarea type="text" name="remark" style="height: 60px;width: 153px;"></textarea>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function () {
        parent.$.messager.progress('close');
        $('#animal-exam-add-form').form({
            url: getContentPath() + '/exam/add.do',
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