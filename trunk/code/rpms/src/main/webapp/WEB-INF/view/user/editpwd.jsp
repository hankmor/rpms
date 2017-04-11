<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/tag.jsp" %>
<script type="text/javascript">
	$(function() {
        parent.$.messager.progress('close');
		$('#editCurrentUserPwdForm').form({
			url : getContentPath()+'/user/updatePwd.do',
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				result = $.parseJSON(result);
				if (result.type=='success') {
					parent.$.modalDialog.handler.dialog('close');
                    Dialog.alert(result.msg,'提示',function(){
						location.replace(location.href = getContentPath() + "/j_spring_security_logout");	
					});
				} else {
					Dialog.alert(result.msg, '错误');
				}
			}
		});
	});
</script>
<form id="editCurrentUserPwdForm" method="post" style="margin-top: 20px;">
    <table class="layout-table" >
        <tr>
            <td style="text-align: right">登录名：</td>
            <td><s:authentication property="name"/></td>
        </tr>
        <tr>
            <td style="text-align: right">原密码：</td>
            <td><input name="oldPwd" type="password" placeholder="请输入原密码" class="easyui-validatebox" data-options="required:true"></td>
        </tr>
        <tr>
            <td style="text-align: right">新密码：</td>
            <td><input name="newPwd" type="password" placeholder="请输入新密码" class="easyui-validatebox" data-options="required:true"></td>
        </tr>
        <tr>
            <td style="text-align: right">重复新密码：</td>
            <td><input name="rePwd" type="password" placeholder="请再次输入新密码" class="easyui-validatebox" data-options="required:true,validType:'equals[\'input[name=newPwd]\']'"></td>
        </tr>
    </table>
</form>