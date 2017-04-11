<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="house-update-form" method="post" style="margin-top: 10px;">
    <table class="layout-table" >
        <input type="hidden" name="id">
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>编号：</td>
            <td><input name="numer" type="text" readonly class="easyui-validatebox" data-options="required:true"></td>
        </tr>
        <tr>
            <td></td>
            <td><span style="color: red;">编号不能修改</span></td>
        </tr>
        <tr>
            <td style="text-align: right">名称：</td>
            <td><input name="name" type="text" class="easyui-validatebox"></td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">所在位置：</td>
            <td>
                <input name="location" type="text" class="easyui-validatebox">
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">描述信息：</td>
            <td><textarea style="width: 153px;" name="description" class="easyui-validatebox"></textarea></td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea style="width: 153px;" name="remark" class="easyui-validatebox"></textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function() {
        var rowData = $("#house-table").datagrid('getSelected');
        parent.$.messager.progress('close');
        $('#house-update-form').form({
            url : getContentPath()+'/house/update.do',
            onSubmit : function() {
                return $(this).form('validate');
            },
            success : function(result) {
                result = $.parseJSON(result);
                if (result.type=='success') {
                    parent.$.modalDialog.handler.dialog('close');
                    //Dialog.info(result.msg,'提示',function(){
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    //});
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        }).form('clear').form('load', rowData);
    });
</script>