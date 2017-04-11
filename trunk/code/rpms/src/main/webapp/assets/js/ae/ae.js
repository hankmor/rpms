/**
 * 动物体检信息管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */
$(function () {
    var animalId = $('#animal-exam-animalId').val();
    /**
     * 加载datagrid
     */
    var dataGrid = $('#animal-exam-table').datagrid({
        title: "动物体检信息列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        singleSelect: false,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/exam/pager.do',
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
                {field: 'weight', title: '体重(kg)', width: 60, align: 'center'},
                {field: 'bodyLength', title: '体长(cm)', width: 60, align: 'center'},
                {field: 'coutourLength', title: '吻长(cm)', width: 60, align: 'center'},
                {field: 'earLength', title: '耳长(cm)', width: 60, align: 'center'},
                {field: 'tailLength', title: '尾长(cm)', width: 60, align: 'center'},
                {field: 'neckGirth', title: '颈围(cm)', width: 60, align: 'center'},
                {field: 'chestGirth', title: '胸围(cm)', width: 60, align: 'center'},
                {field: 'abdominalGirth', title: '腹围(cm)', width: 60, align: 'center'},
                {field: 'leftFrontLegLength', title: '左前肢(cm)', width: 60, align: 'center'},
                {field: 'leftBackLegLength', title: '左后肢(cm)', width: 60, align: 'center'},
                {field: 'temperature', title: '体温(℃)', width: 60, align: 'center'},
                {field: 'examUser', title: '体检员', width: 70, align: 'center'},
                {field: 'examTime', title: '体检时间', width: 70, align: 'center'},
                {field: 'remark', title: '备注', width: 70, align: 'center'}
            ]
        ],
        queryParams: {
            "animalId": animalId
        },
        toolbar: '#exam-animal-toolbar',
        onDblClickCell: function (rowIndex, field, value) {
            if (field != "id") {
                $("#animal-exam-table").datagrid("unselectAll");
                $("#animal-exam-table").datagrid("selectRow", rowIndex);
                var rowData = $("#animal-exam-table").datagrid("getSelected");
                _animal_exam_setEditForm(rowData);
            }
        }
    });

    /** *****************************点击事件和函数************************************** */
    $('#exam-animal-add').click(function () {
        parent.$.modalDialog({
            title: '添加体检信息',
            width: 380,
            height: 630,
            href: getContentPath() + '/exam/toAddPage.do?id=' + animalId,
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

    function _animal_exam_setEditForm(rowData) {
        parent.$.modalDialog({
            title: '修改',
            width: 380,
            height: 630,
            href: getContentPath() + '/exam/toUpdatePage.do?id=' + animalId,
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
     * 编辑按钮点击事件
     */
    $("#exam-animal-edit").click(function () {
        var rowDataArray = $('#animal-exam-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _animal_exam_setEditForm(rowDataArray[0]);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个动物信息！', '警告');
        } else {
            Dialog.warning('请选择要编辑的动物！', '警告');
        }
    });

    $("#exam-animal-delete").click(function () {
        var rows = $('#animal-exam-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，确定要删除所选的体检记录？", function () {
                $.ajax({
                    url: getContentPath() + "/exam/delete.do",
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
                            _animal_exam_reloadDataGrid();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的体检记录！", "警告");
        }
    });

    function _animal_exam_reloadDataGrid() {
        $('#animal-exam-table').datagrid("load", {
            "beginTime": $("#animal-exam-beginTime").datebox('getValue'),
            "endTime": $("#animal-exam-endTime").datebox('getValue'),
            "animalId": animalId
        });
        $('#animal-exam-table').datagrid("uncheckAll");
    }

    /**
     * 查询按钮点击事件
     */
    $("#animal-exam-search").click(function () {
        _animal_exam_reloadDataGrid();
    });

    /**
     * 外观
     */
    $('#exam-animal-facade').click(function () {
        var rowDataArray = $('#animal-exam-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            addTab({
                title: "动物体检-外观特征",
                iconCls: 'icon-exam',
                url: getContentPath() + '/exam/toFacadePage.do?id=' + rowDataArray[0].id
            }, true);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个体检记录的外观信息！', '警告');
        } else {
            Dialog.warning('请选择要编辑外观信息的体检记录！', '警告');
        }
    });

    /**
     * 受伤情况
     */
    $('#exam-animal-wound').click(function () {
        var rowDataArray = $('#animal-exam-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            addTab({
                title: "动物体检-受伤情况",
                iconCls: 'icon-exam',
                url: getContentPath() + '/exam/toWoundPage.do?id=' + rowDataArray[0].id
            }, true);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个体检记录的受伤情况！', '警告');
        } else {
            Dialog.warning('请选择要编辑体检受伤情况的记录！', '警告');
        }
    });
});