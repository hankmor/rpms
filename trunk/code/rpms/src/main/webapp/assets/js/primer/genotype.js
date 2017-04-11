/**
 * 基因型管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */

$(function () {
    /**
     * 加载datagrid
     */
    var dataGrid = $('#genotype-table').datagrid({
        title: "基因型列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/gen/pager.do',
        frozenColumns: [
            [
                {
                    field: 'id',
                    align: 'center',
                    checkbox: true
                }
            ]
        ],
        columns: [
            [
                { field: 'codeA', title: '基因型A', width: 60, align: 'center'},
                { field: 'codeB', title: '基因型B', width: 80, align: 'center'},
                {field: 'primerNo', title: '对应引物编号', width: 70, align: 'center'},
                { field: 'createUserName', title: '记录人', width: 60, align: 'center'},
                { field: 'createTime', title: '记录时间', width: 60, align: 'center'},
                { field: 'updateUserName', title: '最后修改人', width: 60, align: 'center'},
                { field: 'updateTime', title: '最后修改时间', width: 80, align: 'center'},
                { field: 'remark', title: '备注', width: 100, align: 'center'}
            ]
        ],
        queryParams: {
            "primerNo": $("#primer-no").val()
        },
        toolbar: '#genotype-toolbar',
        onDblClickCell: function (rowIndex, field, value) {
            if (field != "id") {
                $("#genotype-table").datagrid("unselectAll");
                $("#genotype-table").datagrid("selectRow", rowIndex);
                var rowData = $("#genotype-table").datagrid("getSelected");
                _genotype_setEditForm(rowData);
            }
        }
    });

    /** *****************************点击事件和函数************************************** */
    /**
     * 修改基因型信息
     *
     * @param rowData
     */
    function _genotype_setEditForm(rowData) {
        parent.$.modalDialog({
            title: '修改基因型信息',
            width: 350,
            height: 250,
            href: getContentPath() + '/gen/toUpdatePage.do',
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
    $("#genotype-primer-search").click(function () {
        _genotype_reloadDataGrid();
    });

    function _genotype_reloadDataGrid() {
        $('#genotype-table').datagrid("load", {
            "primerNo": $("#primer-no").val()
        });
        $('#genotype-table').datagrid("uncheckAll");
    }

    /**
     * 添加按钮点击事件
     */
    $("#genotype-add").click(function () {
        parent.$.modalDialog({
            title: '添加基因型信息',
            width: 350,
            height: 250,
            href: getContentPath() + '/primer/toAddPage.do',
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
    $("#genotype-edit").click(function () {
        var rowDataArray = $('#genotype-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _genotype_setEditForm(rowDataArray[0]);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个基因型信息！', '警告');
        } else {
            Dialog.warning('请选择要编辑的基因型！', '警告');
        }
    });

    /**
     * 删除按钮点击事件
     */
    $("#genotype-delete").click(function () {
        var rows = $('#genotype-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，所选基因型关联的信息将会被删除，请慎重，确定？", function () {
                $.ajax({
                    url: getContentPath() + "/gen/delete.do",
                    type: "post",
                    dataType: "json",
                    data: {
                        "ids": ids
                    },
                    beforeSend: function (jqXHR, settings) {
                        Dialog.fullprogress.open('删除中，请稍候...', "操作");
                    },
                    complete: function (jqXHR, textStatus) {
                        Dialog.fullprogress.close();
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data.type == "error") {
                            Dialog.error(data.msg, "错误");
                        } else {
                            _primer_reloadDataGrid();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的基因型！", "警告");
        }
    });
});