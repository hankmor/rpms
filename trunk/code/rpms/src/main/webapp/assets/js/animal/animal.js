/**
 * 动物管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */

$(function () {
    /**
     * 加载datagrid
     */
    var dataGrid = $('#red-panda-table').datagrid({
        title: "动物列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/rp/pager.do',
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
                {field: 'typeName', title: '物种', width: 50, align: 'center'},
                {field: 'tatooCode', title: '编号', width: 50, align: 'center'},
                {field: 'microchipCode', title: '芯片号', width: 70, align: 'center'},
                { field: 'studbookCode', title: '谱系号', width: 70, align: 'center'},
                { field: 'earCode', title: '耳号', width: 70, align: 'center'},
                { field: 'lipCode', title: '唇号', width: 70, align: 'center'},
                { field: 'name', title: '呼名', width: 70, align: 'center'},
                { field: 'sex', title: '性别', width: 40, align: 'center', formatter: function (value, row, index) {
                    if (value == SEX.FEMALE)
                        return "雌性";
                    else if (value == SEX.MALE)
                        return "雄性";
                }},
                { field: 'age', title: '年龄', width: 40, align: 'center'},
                { field: 'status', title: '状态', width: 40, align: 'center', formatter: function (value, row, index) {
                    if (value == RED_PANDA.STATUS_TRANS_OUT)
                        return "<span style='color: red;'>转出</span>";
                    else if (value == RED_PANDA.STATUS_FEEDING)
                        return "<span style='color: green;'>在养</span>";
                    else if (value == RED_PANDA.STATUS_DEAD)
                        return "<span style='color: darkgray;'>死亡</span>";
                }},
                { field: 'birthDate', title: '出生日期', width: 100, align: 'center'},
                { field: 'chipTime', title: '芯片植入日期', width: 100, align: 'center'},
                { field: 'houseNumber', title: '所在圈舍编号', width: 70, align: 'center'},
                { field: 'fatherChipCode', title: '父亲芯片号', width: 70, align: 'center'},
                { field: 'motherChipCode', title: '母亲芯片号', width: 70, align: 'center'}
            ]
        ],
        queryParams: {
            "microchipCode": $("#red-panda-microchip-no").val(),
            "name": $("#red-panda-name").val(),
            "no" : $("#red-panda-no").val()
        },
        toolbar: '#red-panda-toolbar',
        onDblClickCell: function (rowIndex, field, value) {
            if (field != "id") {
                $("#red-panda-table").datagrid("unselectAll");
                $("#red-panda-table").datagrid("selectRow", rowIndex);
                var rowData = $("#red-panda-table").datagrid("getSelected");
                _red_panda_setEditForm(rowData);
            }
        }
    });

    /** *****************************点击事件和函数************************************** */
    /**
     * 修改信息
     *
     * @param rowData
     */
    function _red_panda_setEditForm(rowData) {
        parent.$.modalDialog({
            title: '修改',
            width: 600,
            height: 480,
            href: getContentPath() + '/rp/toUpdatePage.do',
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
    $("#red-panda-search").click(function () {
        _red_panda_reloadDataGrid();
    });

    function _red_panda_reloadDataGrid() {
        $('#red-panda-table').datagrid("load", {
            "microchipCode": $("#red-panda-microchip-no").val(),
            "name": $("#red-panda-name").val(),
            "no" : $("#red-panda-no").val()
        });
        $('#red-panda-table').datagrid("uncheckAll");
    }

    /**
     * 添加按钮点击事件
     */
    $("#red-panda-add").click(function () {
        parent.$.modalDialog({
            title: '添加',
            width: 600,
            height: 480,
            href: getContentPath() + '/rp/toAddPage.do',
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
    $("#red-panda-edit").click(function () {
        var rowDataArray = $('#red-panda-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _red_panda_setEditForm(rowDataArray[0]);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个动物信息！', '警告');
        } else {
            Dialog.warning('请选择要编辑的动物！', '警告');
        }
    });

    /**
     * 删除按钮点击事件
     */
    $("#red-panda-delete").click(function () {
        var rows = $('#red-panda-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，所选动物关联的信息将会被删除，请慎重，确定？", function () {
                $.ajax({
                    url: getContentPath() + "/rp/delete.do",
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
                            _red_panda_reloadDataGrid();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的动物！", "警告");
        }
    });

    /**
     * 标记按钮点击事件
     */
    $("#red-panda-mark").click(function () {
        var rows = $('#red-panda-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            parent.$.modalDialog({
                title: '标记动物',
                width: 450,
                height: 250,
                href: getContentPath() + '/rp/toMarkPage.do',
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
        } else {
            Dialog.warning("请选择要标记的动物！", "警告");
        }
    });

    /**
     * 照片管理
     */
    $('#red-panda-photo').click(function () {
        var rowDataArray = $('#red-panda-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            addTab({
                title: "动物照片管理",
                iconCls: 'icon-books',
                url: getContentPath() + "/rp/toPhotoPage.do?animalId=" + rowDataArray[0].id
            }, true);
        }
        else {
            Dialog.warning('请选择一只动物！', '警告');
        }
    });

    /**
     * 体检管理
     */
    $('#red-panda-exam').click(function () {
        var rowDataArray = $('#red-panda-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            addTab({
                title: "动物体检管理",
                iconCls: 'icon-exam',
                url: getContentPath() + "/rp/toExamPage.do?animalId=" + rowDataArray[0].id
            }, true);
        }
        else {
            Dialog.warning('请选择一只动物！', '警告');
        }
    });

    /**
     * 谱系
     */
    $('#red-panda-studbook').click(function () {
        var rowDataArray = $('#red-panda-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            addTab({
                title: "动物谱系分析",
                iconCls: 'icon-exam',
                url: getContentPath() + "/rp/px.do?animalId=" + rowDataArray[0].id
            }, true);
        }
        else {
            Dialog.warning('请选择一只动物！', '警告');
        }
    });
})