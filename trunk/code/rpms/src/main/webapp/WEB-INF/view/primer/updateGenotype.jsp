<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="genotype-update-form-primer" method="post" style="margin-top: 10px;">
    <input type="hidden" name="id" value="${genotype.id}">
    <table class="layout-table">
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>基因型：</td>
            <td><input name="codeA" type="text" class="easyui-validatebox" validType="digit"
                       data-options="required:true" value="${genotype.codeA}"></td>
        </tr>
        <%--<tr>
            <td style="text-align: right"><span style="color: red;">*</span>基因型A：</td>
            <td><input name="codeA" type="text" class="easyui-validatebox" validType="digit"
                       data-options="required:true" value="${genotype.codeA}"></td>
        </tr>
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>基因型B：</td>
            <td><input name="codeB" type="text" class="easyui-validatebox" validType="digit"
                       data-options="required:true" value="${genotype.codeB}"></td>
        </tr>--%>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea style="width: 153px;" name="remark" class="easyui-validatebox">${genotype.remark}</textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    $(function() {
        parent.$.messager.progress('close');
        $('#genotype-update-form-primer').form({
            url : getContentPath()+'/gen/update.do',
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
        });
    });
</script>