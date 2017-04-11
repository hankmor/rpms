/**
 * 系统用户管理
 * 
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */

$(function() {
	/**
	 * 加载datagrid
	 */
	var dataGrid = $('#feeder-table').datagrid({
		title : "用户列表",
		fitColumns : true,
		checkOnSelect : true,
		selectOnCheck : true,
		nowrap : true,
		pagination : true,
		rownumbers : true,
        pageSize : 20,
		fit : true,
		url : getContentPath() + '/user/pager.do',
		frozenColumns : [ [ {
			field : 'id',
			align : 'center',
			checkbox : true
		} ] ],
		columns : [
            [{field : 'username', title : '用户名', width : 100, align: 'center'},
            { field : 'trueName', title : '姓名', width : 80, align: 'center'},
            { field : 'sex', title : '性别', width : 60, formatter : function(value, row, index) {
                if (value == SEX.MALE) {
                    return "男";
                } else {
                    return "女";
                }
            }, align: 'center'},
            { field : 'age', title : '年龄', width : 40, align: 'right'},
            { field : 'status', title : '状态', width : 40, formatter : function(value, row, index) {
				if (value == USER.STATUS_NOT_ENABLE) {
					return "<span style='color: red;'>禁用</span>";
				} else if (value == USER.STATUS_ENABLE) {
					return "<span style='color: green;'>启用</span>";
				}
			}, align: 'center'},
            { field : 'createTime', title : '创建时间', width : 100, align: 'center'}
            ]],
		queryParams : {
			"username" : $("#feeder-username").val(),
			"trueName" : $("#feeder-trueName").val()
		},
		toolbar : '#feeder-toolbar',
		onDblClickCell : function(rowIndex, field, value) {
			if (field != "id") {
				$("#feeder-table").datagrid("unselectAll");
				$("#feeder-table").datagrid("selectRow", rowIndex);
				var rowData = $("#feeder-table").datagrid("getSelected");
				feeder_setEditForm(rowData);
			}
		}
	});

	/** *****************************点击事件和函数************************************** */
	/**
	 * 修改用户信息
	 * 
	 * @param rowData
	 */
	function feeder_setEditForm(rowData) {
        parent.$.modalDialog({
            title: '修改用户信息',
            width: 450,
            height: 270,
            href: getContentPath() + '/user/toUpdatePage.do',
            buttons: [
                {
                    text: '确定',
                    iconCls: 'icon-ok',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = dataGrid;
                        var f = parent.$.modalDialog.handler.find('form');
                        f.submit();
                    }
                },
                {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function () {
                        parent.$.modalDialog.handler.dialog('close');
                    }
                }
            ]
        });
	}

	/**
	 * 查询按钮点击事件
	 */
	$("#feeder-search").click(function() {
        _feeder_reloadDataGrid();
	});

    function _feeder_reloadDataGrid() {
        $('#feeder-table').datagrid("load", {
            "username" : $("#feeder-username").val(),
            "trueName" : $("#feeder-trueName").val()
        });
        $('#feeder-table').datagrid("uncheckAll");
    }

	/**
	 * 添加按钮点击事件
	 */
	$("#feeder-add").click(function() {
        parent.$.modalDialog({
            title: '添加用户',
            width: 450,
            height: 270,
            href: getContentPath() + '/user/toAddPage.do',
            buttons: [
                {
                    text: '确定',
                    iconCls: 'icon-ok',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = dataGrid;
                        var f = parent.$.modalDialog.handler.find('form');
                        f.submit();
                    }
                },
                {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function () {
                        parent.$.modalDialog.handler.dialog('close');
                    }
                }
            ]
        });
	});

	/**
	 * 编辑按钮点击事件
	 */
	$("#feeder-edit").click(function() {
		var rowDataArray = $('#feeder-table').datagrid('getSelections');
		if (rowDataArray.length == 1) {
			feeder_setEditForm(rowDataArray[0]);
		} else if (rowDataArray.length > 1) {
			Dialog.warning('一次只能编辑一个用户信息！', '警告');
		} else {
			Dialog.warning('请选择要编辑的用户！', '警告');
		}
	});

	function _feeder_setStatus(status) {
        var option = status == 0 ? "禁用" : "启用";
		var url = status == 0 ? "/user/setForbidden.do" : "/user/setUsing.do";
		var rows = $('#feeder-table').datagrid('getChecked');
		var ids = $(rows).map(function(i, row) {
			return row.id;
		}).get().join(",");

		if (ids != '') {
			Dialog.confirm("您确定要" + option + "所选用户账号？", function() {
				$.ajax({
                    url : getContentPath() + url,
					type : "post",
					dataType : "json",
					data : {
						"ids" : ids,
						"status" : status
					},
					beforeSend : function(jqXHR, settings) {
						Dialog.fullprogress.open('处理中，请稍候...', "操作");
					},
					complete : function(jqXHR, textStatus) {
						Dialog.fullprogress.close();
					},
					success : function(data, textStatus, jqXHR) {
						if (data.type == "error") {
							Dialog.error(data.msg, "错误");
						} else {
							_feeder_reloadDataGrid();
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						Dialog.error("操作失败，请稍后重试！", "错误");
					}
				});
			}, "确认");
		} else {
			Dialog.warning("请选择要" + option + "的用户！", "警告");
		}
	}

	/**
	 * 启用账号
	 */
	$("#feeder-using").click(function() {
		_feeder_setStatus(1);
	});

	/**
	 * 禁用账号
	 */
	$("#feeder-forbidden").click(function() {
        _feeder_setStatus(0)
	});


	/**
	 * 删除按钮点击事件
	 */
	$("#feeder-delete").click(function() {
		var rows = $('#feeder-table').datagrid('getChecked');
		var ids = $(rows).map(function(i, row) {
			return row.id;
		}).get().join(",");

		if (ids != '') {
			Dialog.confirm("您确定要删除所选用户？", function() {
				$.ajax({
					url : getContentPath() + "/user/delete.do",
					type : "post",
					dataType : "json",
					data : {
						"ids" : ids
					},
					beforeSend : function(jqXHR, settings) {
						Dialog.fullprogress.open('删除中，请稍候...', "操作");
					},
					complete : function(jqXHR, textStatus) {
						Dialog.fullprogress.close();
					},
					success : function(data, textStatus, jqXHR) {
						if (data.type == "error") {
							Dialog.error(data.msg, "错误");
						} else {
							_feeder_reloadDataGrid();
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						Dialog.error("删除失败，请稍后重试！", "错误");
					}
				});
			}, "确认");
		} else {
			Dialog.warning("请选择要删除的用户！", "警告");
		}
	});

    /**
     * 重置密码点击事件
     */
    $("#feeder-resetpwd").click(function() {
        var rows = $('#feeder-table').datagrid('getChecked');
        var ids = $(rows).map(function(i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("您确定要重置所选用户密码？", function() {
                $.ajax({
                    url : getContentPath() + "/user/resetPwd.do",
                    type : "post",
                    dataType : "json",
                    data : {
                        "ids" : ids
                    },
                    beforeSend : function(jqXHR, settings) {
                        Dialog.fullprogress.open('处理中，请稍候...', "操作");
                    },
                    complete : function(jqXHR, textStatus) {
                        Dialog.fullprogress.close();
                    },
                    success : function(data, textStatus, jqXHR) {
                        if (data.type == "error") {
                            Dialog.error(data.msg, "错误");
                        } else {
                            _feeder_reloadDataGrid();
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown) {
                        Dialog.error("重置失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要重置密码的用户！", "警告");
        }
    });
});