<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
        parent.$.messager.progress('close');
		$('#feeder-add-form').form({
			url : getContentPath()+'/user/add.do',
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
<form id="feeder-add-form" method="post" style="margin-top: 10px;">
    <table class="layout-table" >
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>用户名：</td>
            <td><input name="username" type="text" class="easyui-validatebox" data-options="required:true,validType:'simpleString'"></td>
        </tr>
        <tr>
            <td style="text-align: right">姓名：</td>
            <td><input name="trueName" type="text" class="easyui-validatebox" validType="chinese"></td>
        </tr>
        <tr>
            <td style="text-align: right">姓别：</td>
            <td>
                <label class="checkbox-inline">
                    <input type="radio" name="sex" value="true" checked>男
                </label>
                <label class="checkbox-inline">
                    <input type="radio" name="sex" value="false">女
                </label>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">年龄：</td>
            <td><input name="age" type="text" class="easyui-validatebox" validType="digit"></td>
        </tr>
        <tr>
            <td style="text-align: right">角色：</td>
            <td>
                <label class="checkbox-inline">
                    <input type="checkbox" name="role" value="ROLE_MANAGER">管理员
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="role" value="ROLE_FEEDER">饲养员
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="role" value="ROLE_CODE_CARE_USER">医护人员
                </label>
            </td>
        </tr>
    </table>
</form>